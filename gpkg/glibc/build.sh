TERMUX_PKG_HOMEPAGE=https://www.gnu.org/software/libc/
TERMUX_PKG_DESCRIPTION="GNU C Library"
TERMUX_PKG_LICENSE="GPL-3.0, LGPL-3.0"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=2.41
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://ftp.gnu.org/gnu/libc/glibc-$TERMUX_PKG_VERSION.tar.xz
TERMUX_PKG_SHA256=a5a26b22f545d6b7d7b3dd828e11e428f24f4fac43c934fb071b6a7d0828e901
TERMUX_PKG_DEPENDS="linux-api-headers-glibc"
TERMUX_PKG_RECOMMENDS="glibc-runner"
TERMUX_PKG_NO_STATICSPLIT=true
TERMUX_PKG_CONFFILES="glibc/etc/gai.conf, glibc/etc/locale.gen"
TERMUX_PKG_SEPARATE_SUB_DEPENDS=true
TERMUX_PKG_BUILD_MULTILIB=true

termux_step_pre_configure() {
	if [ "$TERMUX_PACKAGE_LIBRARY" != "glibc" ]; then
		termux_error_exit "Compilation is only possible based on glibc"
	fi

	# disabling clone3 function
	rm ${TERMUX_PKG_SRCDIR}/sysdeps/unix/sysv/linux/*/clone3.S
	# disabling editing of `ldd` script for x86_64 arch
	rm ${TERMUX_PKG_SRCDIR}/sysdeps/unix/sysv/linux/x86_64/configure*

	# installing special scripts for correct operation of system calls
	cp ${TERMUX_PKG_BUILDER_DIR}/{shm{at,ctl,dt,get}.c,mprotect.c,syscall.c,fakesyscall*.h,fake_epoll_pwait2.c,setfs{u,g}id.c} \
		${TERMUX_PKG_SRCDIR}/sysdeps/unix/sysv/linux/

	# installing and configuring scripts for parsing users/groups according to the android standard
	cp ${TERMUX_PKG_BUILDER_DIR}/{android_passwd_group.*,android_system_user_ids.h} \
		${TERMUX_PKG_SRCDIR}/nss/
	bash ${TERMUX_PKG_BUILDER_DIR}/gen-android-ids.sh ${TERMUX_BASE_DIR} \
		${TERMUX_PKG_SRCDIR}/nss/android_ids.h \
		${TERMUX_PKG_BUILDER_DIR}/android_system_user_ids.h

	# installing a syslog script that can work with the android log system
	cp ${TERMUX_PKG_BUILDER_DIR}/syslog.c ${TERMUX_PKG_SRCDIR}/misc/

	# installing shmem-android scripts for system V shared memory emulation
	cp ${TERMUX_PKG_BUILDER_DIR}/shmem-android.* ${TERMUX_PKG_SRCDIR}/sysvipc/

	# `fakesyscall.json` - json file that stores a list of unsupported syscalls for Termux in keys,
	# the name of which indicates the fakesyscall function and how it will be launched
	# == Syntax ==
	# {
	#   "fakesyscall_1()": [
	#     "syscall_1",
	#     "syscall_2"
	#   ],
	#   "fakesyscall_2(a0, a1, a2, a3, a4, a5)": [
	#     "syscall_3",
	#     "syscall_4"
	#   ]
	# }
	# == Rules ===
	# - The name syscall and the name of the function fakesyscall must not be repeated
	# - Specify the syscall name without the leading `__NR_` prefix
	# ============
	for i in aarch64 arm i386 x86_64/64; do
		mv ${TERMUX_PKG_SRCDIR}/sysdeps/unix/sysv/linux/${i///*/}/syscall.S \
			${TERMUX_PKG_SRCDIR}/sysdeps/unix/sysv/linux/${i///*/}/syscallS.S
		local header_disabled_syscall="${TERMUX_PKG_SRCDIR}/sysdeps/unix/sysv/linux/${i}/disabled-syscall.h"
		{
			for j in $(jq -r '.[] | .[]' ${TERMUX_PKG_BUILDER_DIR}/fakesyscall.json); do
				grep "#define __NR_${j} " ${TERMUX_PKG_SRCDIR}/sysdeps/unix/sysv/linux/${i}/arch-syscall.h || true
				sed -i "/#define __NR_${j} /d" ${TERMUX_PKG_SRCDIR}/sysdeps/unix/sysv/linux/${i}/arch-syscall.h
			done
		} >> $header_disabled_syscall
		{
			echo -e "\n#define DISABLED_SYSCALL_WITH_FAKESYSCALL \\"
			local IFS=$'\n'
			for j in $(jq -r '. | keys | .[]' ${TERMUX_PKG_BUILDER_DIR}/fakesyscall.json); do
				local need_return=false
				for z in $(jq -r '."'${j}'" | .[]' ${TERMUX_PKG_BUILDER_DIR}/fakesyscall.json); do
					if grep -q "^#define __NR_${z} " $header_disabled_syscall; then
						echo -e "\tcase __NR_${z}: \\"
						need_return=true
					elif [[ ${z} =~ ^[0-9]+$ ]]; then
						echo -e "\tcase ${z}: \\"
						need_return=true
					fi
				done
				[ "${need_return}" = "true" ] && echo -e "\t\treturn ${j}; \\"
			done
			unset IFS
		} >> $header_disabled_syscall
		sed -i '$ s| \\||' $header_disabled_syscall
	done

	# replacing some hard paths that may not exist in some device
	for i in /dev/stderr:/proc/self/fd/2 \
		/dev/stdin:/proc/self/fd/0 \
		/dev/stdout:/proc/self/fd/1; do
		for j in $(grep -s -r -l ${i%%:*} ${TERMUX_PKG_SRCDIR}); do
			sed -i "s|${i%%:*}|${i//*:}|g" ${j}
		done
	done

	# adding revision to glibc version
	sed -i "s/${TERMUX_PKG_VERSION}/${TERMUX_PKG_FULLVERSION_FOR_PACMAN}/" ${TERMUX_PKG_SRCDIR}/version.h

	# specifying the current release (use only when developing glibc)
	#sed -i "s/stable/dev.$(git -C ${TERMUX_PKG_BUILDER_DIR} rev-parse --short HEAD).$(date +%Y%m%d%H%M%S)/" ${TERMUX_PKG_SRCDIR}/version.h
}

termux_step_configure() {
	echo "slibdir=${TERMUX__PREFIX__LIB_DIR}" > configparms
	echo "rtlddir=${TERMUX__PREFIX__LIB_DIR}" >> configparms
	echo "sbindir=${TERMUX_PREFIX}/bin" >> configparms
	echo "rootsbindir=${TERMUX_PREFIX}/bin" >> configparms

	local _configure_flags=()
	case $TERMUX_ARCH in
		"aarch64") _configure_flags+=(--enable-memory-tagging --enable-fortify-source);;
		"arm"|"i686") _configure_flags+=(--enable-fortify-source);;
		"x86_64") _configure_flags+=(--enable-cet);;
	esac

	local _pkgversion="GNU libc for Android"
	if [ -n "${TERMUX_APP_PACKAGE-}" ]; then
		_pkgversion+="/${TERMUX_APP_PACKAGE}"
	fi

	CFLAGS="${CFLAGS/-Wp,-D_FORTIFY_SOURCE=2 / }"
	CFLAGS="${CFLAGS/-Werror / }"
	export TERMUX_ARCH TERMUX_REAL_ARCH
	if [ "$TERMUX_ARCH" != "$TERMUX_REAL_ARCH" ]; then
		CFLAGS+=" -DMULTILIB_GLIBC"
	fi
	${TERMUX_PKG_SRCDIR}/configure \
		--prefix=$TERMUX_PREFIX \
		--libdir=$TERMUX__PREFIX__LIB_DIR \
		--libexecdir=$TERMUX__PREFIX__LIB_DIR \
		--includedir=$TERMUX__PREFIX__INCLUDE_DIR \
		--host=$TERMUX_HOST_PLATFORM \
		--build=$TERMUX_HOST_PLATFORM \
		--target=$TERMUX_HOST_PLATFORM \
		--with-bugurl=https://github.com/termux-pacman/glibc-packages/issues \
		--with-pkgversion="${_pkgversion}" \
		--enable-bind-now \
		--enable-fortify-source \
		--disable-multi-arch \
		--enable-stack-protector=strong \
		--enable-systemtap \
		--disable-nscd \
		--disable-profile \
		--disable-werror \
		--disable-default-pie \
		"${_configure_flags[@]}"
}

termux_step_make() {
	make -O
	if [ "$TERMUX_ARCH" = "$TERMUX_REAL_ARCH" ]; then
		make info
	fi
}

termux_glibc_make_syscall_without_fsc() {
	local libname="libsyscall_without_fsc.so"
	echo "Compiling '${libname}'..."
	$CC ${TERMUX_PKG_BUILDER_DIR}/syscall.c -o ${TERMUX__PREFIX__LIB_DIR}/${libname} \
		-shared -DWITHOUT_FAKESYSCALL
	echo "DONE"
}

termux_step_make_install() {
	rm -fr ${TERMUX__PREFIX__INCLUDE_DIR}/gnu

	if [ "$TERMUX_ON_DEVICE_BUILD" = "true" ]; then
		# If there have been no glibc updates on the device for a long time,
		# then when installing glibc components in the usual way (`make install`),
		# the glibc environment may break. Therefore, you need to install the libraries first,
		# and then everything else.
		local glibc_dir="${TERMUX_PKG_TMPDIR}/glibc/"
		mkdir -p ${glibc_dir}
		make DESTDIR=${glibc_dir} elf/ldso_install install-lib
		cp -r ${TERMUX_PKG_BUILDDIR}/libc.so ${glibc_dir}/${TERMUX__PREFIX__LIB_DIR}/libc.so.6
		LD_PRELOAD="" LD_LIBRARY_PATH="" /system/bin/cp -r ${glibc_dir}/${TERMUX__PREFIX__LIB_DIR}/* ${TERMUX__PREFIX__LIB_DIR}
	fi
	make install

	rm -f ${TERMUX_PREFIX}/etc/ld.so.cache
	rm -f ${TERMUX_PREFIX}/bin/{tzselect,zdump,zic}

	install -dm755 ${TERMUX__PREFIX__LIB_DIR}/tmpfiles.d
	install -m644 ${TERMUX_PKG_SRCDIR}/nscd/nscd.conf ${TERMUX_PREFIX}/etc/nscd.conf
	install -m644 ${TERMUX_PKG_SRCDIR}/nscd/nscd.tmpfiles ${TERMUX__PREFIX__LIB_DIR}/tmpfiles.d/nscd.conf
	install -m644 ${TERMUX_PKG_SRCDIR}/posix/gai.conf ${TERMUX_PREFIX}/etc/gai.conf
	install -m755 ${TERMUX_PKG_BUILDER_DIR}/locale-gen ${TERMUX_PREFIX}/bin
	sed -i "s|@TERMUX_PREFIX@|$TERMUX_PREFIX|g; s|@TERMUX_PREFIX_CLASSICAL@|$TERMUX_PREFIX_CLASSICAL|g" \
		${TERMUX_PREFIX}/bin/locale-gen

	install -m644 ${TERMUX_PKG_BUILDER_DIR}/locale.gen.txt ${TERMUX_PREFIX}/etc/locale.gen
	sed -e '1,3d' -e 's|/| |g' -e 's|\\| |g' -e 's|^|#|g' \
		${TERMUX_PKG_SRCDIR}/localedata/SUPPORTED >> ${TERMUX_PREFIX}/etc/locale.gen

	sed -e '1,3d' -e 's|/| |g' -e 's| \\||g' \
		${TERMUX_PKG_SRCDIR}/localedata/SUPPORTED > ${TERMUX_PREFIX}/share/i18n/SUPPORTED

	install -dm755 ${TERMUX__PREFIX__LIB_DIR}/locale
	make -C ${TERMUX_PKG_SRCDIR}/localedata objdir=${TERMUX_PKG_BUILDDIR} \
		SUPPORTED-LOCALES="C.UTF-8/UTF-8 en_US.UTF-8/UTF-8" install-locale-files
	sed -i '/#C\.UTF-8 /d' ${TERMUX_PREFIX}/etc/locale.gen

	install -Dm644 ${TERMUX_PKG_BUILDER_DIR}/sdt.h ${TERMUX__PREFIX__INCLUDE_DIR}/sys/sdt.h
	install -Dm644 ${TERMUX_PKG_BUILDER_DIR}/sdt-config.h ${TERMUX__PREFIX__INCLUDE_DIR}/sys/sdt-config.h

	ln -sfr $PATH_DYNAMIC_LINKER ${TERMUX_PREFIX}/bin/ld.so
	ln -sfr $PATH_DYNAMIC_LINKER ${TERMUX__PREFIX__LIB_DIR}/ld.so

	termux_glibc_make_syscall_without_fsc
}

termux_step_make_install_multilib() {
	local glibc32_dir="${TERMUX_PKG_TMPDIR}/glibc32/"
	mkdir -p ${glibc32_dir}
	make DESTDIR=${glibc32_dir} install

	cp -TR ${glibc32_dir}/${TERMUX__PREFIX__LIB_DIR} $TERMUX__PREFIX__LIB_DIR
	cp -TR ${glibc32_dir}/${TERMUX__PREFIX__INCLUDE_DIR} $TERMUX__PREFIX__INCLUDE_DIR
	cp -r ${glibc32_dir}/${TERMUX_PREFIX}/bin/ldd ${TERMUX_PREFIX}/bin/ldd32
	cp -r ${glibc32_dir}/${TERMUX_PREFIX}/bin/ldconfig ${TERMUX_PREFIX}/bin/ldconfig32
	cp -r ${glibc32_dir}/${TERMUX_PREFIX}/bin/getconf ${TERMUX_PREFIX}/bin/getconf32
	sed -i 's/ldd/ldd32/g' ${TERMUX_PREFIX}/bin/ldd32

	rm -fr ${TERMUX__PREFIX__LIB_DIR}/locale
	ln -sfr ${TERMUX__PREFIX__BASE_LIB_DIR}/locale ${TERMUX__PREFIX__LIB_DIR}/locale

	ln -sfr ${TERMUX__PREFIX__LIB_DIR}/${DYNAMIC_LINKER} $PATH_DYNAMIC_LINKER
	ln -sfr ${TERMUX__PREFIX__LIB_DIR}/${DYNAMIC_LINKER} ${TERMUX_PREFIX}/bin/ld32.so
	ln -sfr ${TERMUX__PREFIX__LIB_DIR}/${DYNAMIC_LINKER} ${TERMUX__PREFIX__LIB_DIR}/ld.so

	termux_glibc_make_syscall_without_fsc
}
