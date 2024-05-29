TERMUX_PKG_HOMEPAGE=https://www.gnu.org/software/libc/
TERMUX_PKG_DESCRIPTION="GNU C Library"
TERMUX_PKG_LICENSE="GPL-3.0, LGPL-3.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=2.39
TERMUX_PKG_REVISION=5
TERMUX_PKG_SRCURL=https://ftp.gnu.org/gnu/libc/glibc-$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=f77bd47cf8170c57365ae7bf86696c118adb3b120d3259c64c502d3dc1e2d926
TERMUX_PKG_DEPENDS="linux-api-headers-glibc"
TERMUX_PKG_RECOMMENDS="glibc-runner"
TERMUX_PKG_NO_STATICSPLIT=true
TERMUX_PKG_CONFFILES="glibc/etc/gai.conf, glibc/etc/locale.gen"
TERMUX_PKG_SEPARATE_SUB_DEPENDS=true

# Variables for glibc32 compilation
TERMUX_PKG_BUILD32=$(test $TERMUX_ARCH = "aarch64" || test $TERMUX_ARCH = "arm" && echo "true" || echo "false")
TERMUX_PKG_BUILDDIR32="${TERMUX_TOPDIR}/${TERMUX_PKG_NAME}/build32"
#if [ "$TERMUX_PKG_BUILD32" = "true" ]; then
#	TERMUX_PKG_BUILD_DEPENDS="glibc32"
#fi

termux_setup_build32() {
	case $TERMUX_ARCH in
		"aarch64")
			TERMUX_ARCH="arm"
			TERMUX_HOST_PLATFORM="arm-linux-gnueabihf";;
		"x86_64")
			TERMUX_ARCH="i686"
			TERMUX_HOST_PLATFORM="i686-linux-gnu";;
	esac
	termux_step_setup_toolchain
	cd ${TERMUX_PKG_BUILDDIR32}
}

termux_step_pre_configure() {
	if [ "$TERMUX_PACKAGE_LIBRARY" != "glibc" ]; then
		termux_error_exit "Compilation is only possible based on glibc"
	fi

	for i in shmem-android.h shmat.c  shmctl.c  shmdt.c  shmget.c mprotect.c syscall.c fake-syscall.h; do
		install -Dm644 "${TERMUX_PKG_BUILDER_DIR}/${i}" "${TERMUX_PKG_SRCDIR}/sysdeps/unix/sysv/linux/${i}"
	done

	rm ${TERMUX_PKG_SRCDIR}/sysdeps/unix/sysv/linux/*/clone3.S
	rm ${TERMUX_PKG_SRCDIR}/sysdeps/unix/sysv/linux/x86_64/configure*

	for i in android_passwd_group.h android_passwd_group.c android_system_user_ids.h; do
		cp ${TERMUX_PKG_BUILDER_DIR}/${i} ${TERMUX_PKG_SRCDIR}/nss/
	done
	bash ${TERMUX_PKG_BUILDER_DIR}/gen-android-ids.sh ${TERMUX_BASE_DIR} \
		${TERMUX_PKG_SRCDIR}/nss/android_ids.h \
		${TERMUX_PKG_BUILDER_DIR}/android_system_user_ids.h

	# `disabled-syscalls` - a file that contains a list of system calls that should be disabled
	for i in aarch64 arm i386 x86_64/64; do
		mv ${TERMUX_PKG_SRCDIR}/sysdeps/unix/sysv/linux/${i///*/}/syscall.S \
			${TERMUX_PKG_SRCDIR}/sysdeps/unix/sysv/linux/${i///*/}/syscallS.S
		{
			for j in $(awk '{printf "__NR_" $1 " "}' ${TERMUX_PKG_BUILDER_DIR}/disabled-syscalls); do
				grep "#define ${j} " ${TERMUX_PKG_SRCDIR}/sysdeps/unix/sysv/linux/${i}/arch-syscall.h || true
				sed -i "/#define ${j} /d" ${TERMUX_PKG_SRCDIR}/sysdeps/unix/sysv/linux/${i}/arch-syscall.h
			done
		} >> ${TERMUX_PKG_SRCDIR}/sysdeps/unix/sysv/linux/${i}/disabled-syscall.h
	done

	if [ "$TERMUX_PKG_BUILD32" = "true" ]; then
		rm -fr ${TERMUX_PKG_BUILDDIR32}
		mkdir -p ${TERMUX_PKG_BUILDDIR32}
	fi
}

termux_glibc_configure() {
	local libdir="${1}"

	echo "slibdir=${TERMUX_PREFIX}/${libdir}" > configparms
	echo "rtlddir=${TERMUX_PREFIX}/${libdir}" >> configparms
	echo "sbindir=${TERMUX_PREFIX}/bin" >> configparms
	echo "rootsbindir=${TERMUX_PREFIX}/bin" >> configparms

	local _configure_flags=()
	case $TERMUX_ARCH in
		"aarch64") _configure_flags+=(--enable-memory-tagging --enable-fortify-source);;
		"arm"|"i686") _configure_flags+=(--enable-fortify-source);;
		"x86_64") _configure_flags+=(--enable-cet);;
	esac

	${TERMUX_PKG_SRCDIR}/configure \
		--prefix=$TERMUX_PREFIX \
		--libdir=${TERMUX_PREFIX}/${libdir} \
		--libexecdir=${TERMUX_PREFIX}/${libdir} \
		--host=$TERMUX_HOST_PLATFORM \
		--build=$TERMUX_HOST_PLATFORM \
		--target=$TERMUX_HOST_PLATFORM \
		--with-bugurl=https://github.com/termux-pacman/glibc-packages/issues \
		--enable-bind-now \
		--disable-multi-arch \
		--enable-stack-protector=strong \
		--enable-systemtap \
		--disable-nscd \
		--disable-profile \
		--disable-werror \
		--disable-default-pie \
		"${_configure_flags[@]}"
}

termux_step_configure() {
	termux_glibc_configure "lib"

	if [ "$TERMUX_PKG_BUILD32" = "true" ]; then
		(
			termux_setup_build32
			termux_glibc_configure "lib32"
			echo 'build-programs=no' >> configparms
		)
	fi
}

termux_step_make() {
	make -O
	make info

	if [ "$TERMUX_PKG_BUILD32" = "true" ]; then
		(
			termux_setup_build32
			make -O
		)
	fi

	elf/ld.so --library-path "$PWD" locale/localedef -c \
		-f ${TERMUX_PKG_SRCDIR}/localedata/charmaps/UTF-8 \
		-i ${TERMUX_PKG_SRCDIR}/localedata/locales/C ./C.UTF-8/
}

termux_step_make_install() {
	rm -fr ${TERMUX_PREFIX}/include/gnu

	make install_root="/" install

	rm -f ${TERMUX_PREFIX}/etc/ld.so.cache
	rm -f ${TERMUX_PREFIX}/bin/{tzselect,zdump,zic}

	install -dm755 ${TERMUX_PREFIX}/lib/tmpfiles.d
	install -m644 ${TERMUX_PKG_SRCDIR}/nscd/nscd.conf ${TERMUX_PREFIX}/etc/nscd.conf
	install -m644 ${TERMUX_PKG_SRCDIR}/nscd/nscd.tmpfiles ${TERMUX_PREFIX}/lib/tmpfiles.d/nscd.conf
	install -m644 ${TERMUX_PKG_SRCDIR}/posix/gai.conf ${TERMUX_PREFIX}/etc/gai.conf
	install -m755 ${TERMUX_PKG_BUILDER_DIR}/locale-gen ${TERMUX_PREFIX}/bin
	sed -i "s|@TERMUX_PREFIX@|$TERMUX_PREFIX|g; s|@TERMUX_PREFIX_CLASSICAL@|$TERMUX_PREFIX_CLASSICAL|g" \
		${TERMUX_PREFIX}/bin/locale-gen

	install -m644 ${TERMUX_PKG_BUILDER_DIR}/locale.gen.txt ${TERMUX_PREFIX}/etc/locale.gen
	sed -e '1,3d' -e 's|/| |g' -e 's|\\| |g' -e 's|^|#|g' \
		${TERMUX_PKG_SRCDIR}/localedata/SUPPORTED >> ${TERMUX_PREFIX}/etc/locale.gen

	sed -e '1,3d' -e 's|/| |g' -e 's| \\||g' \
		${TERMUX_PKG_SRCDIR}/localedata/SUPPORTED > ${TERMUX_PREFIX}/share/i18n/SUPPORTED

	install -dm755 ${TERMUX_PREFIX}/lib/locale
	cp -r ./C.UTF-8 -t ${TERMUX_PREFIX}/lib/locale
	sed -i '/#C\.UTF-8 /d' ${TERMUX_PREFIX}/etc/locale.gen

	install -Dm644 ${TERMUX_PKG_BUILDER_DIR}/sdt.h ${TERMUX_PREFIX}/include/sys/sdt.h
	install -Dm644 ${TERMUX_PKG_BUILDER_DIR}/sdt-config.h ${TERMUX_PREFIX}/include/sys/sdt-config.h

	ln -sfr $PATH_DYNAMIC_LINKER $TERMUX_PREFIX/bin/ld.so
	ln -sfr $PATH_DYNAMIC_LINKER $TERMUX_PREFIX/lib/ld.so

	if [ "$TERMUX_PKG_BUILD32" = "true" ]; then
		(
			termux_setup_build32

			make DESTDIR=${TERMUX_PKG_BUILDDIR32} install

			cp -r ${TERMUX_PKG_BUILDDIR32}/${TERMUX_PREFIX}/lib32 ${TERMUX_PREFIX}

			dynamic_linker="${PATH_DYNAMIC_LINKER##*/}"
			ln -sfr $TERMUX_PREFIX/lib32/$dynamic_linker $TERMUX_PREFIX/lib/$dynamic_linker
			ln -sfr $TERMUX_PREFIX/lib32/$dynamic_linker $TERMUX_PREFIX/lib32/ld.so
		)
	fi
}
