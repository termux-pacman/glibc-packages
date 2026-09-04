TERMUX_PKG_HOMEPAGE=https://ffmpeg.org/
TERMUX_PKG_DESCRIPTION="Complete solution to record, convert and stream audio and video"
TERMUX_PKG_LICENSE="GPL-3.0, LGPL-3.0"
TERMUX_PKG_LICENSE_FILE="LICENSE.md, COPYING.GPLv2, COPYING.GPLv3, COPYING.LGPLv2.1, COPYING.LGPLv3"
TERMUX_PKG_MAINTAINER="@termux-pacman"
TERMUX_PKG_VERSION=7.1
TERMUX_PKG_SRCURL=https://ffmpeg.org/releases/ffmpeg-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=40973d44970fac1db273915f67f6a6b6a5778098877519647681720eb74520a9
TERMUX_PKG_DEPENDS="glibc, libbz2-glibc, freetype-glibc, fontconfig-glibc, harfbuzz-glibc, libgnutls-glibc, libiconv-glibc, libjpeg-turbo-glibc, libmp3lame-glibc, libogg-glibc, libopus-glibc, libpng-glibc, libvorbis-glibc, libwebp-glibc, libxml2-glibc, openssl-glibc, zlib-glibc, zstd-glibc, liblzma-glibc, libflac-glibc, libmpg123-glibc, libdrm-glibc, libx11-glibc, libxext-glibc, alsa-lib-glibc, libpulse-glibc, gcc-libs-glibc"
TERMUX_PKG_BUILD_DEPENDS="pkgconf-glibc"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_configure() {
	local _extra_args=""

	case "$TERMUX_ARCH" in
		aarch64) _extra_args+=" --arch=aarch64 --enable-neon" ;;
		arm)     _extra_args+=" --arch=arm --enable-neon" ;;
		x86_64)  _extra_args+=" --arch=x86_64 --enable-x86asm" ;;
		i686)    _extra_args+=" --arch=x86 --disable-x86asm" ;;
	esac

	./configure \
		--prefix="$TERMUX_PREFIX" \
		--libdir="$TERMUX_PREFIX/lib" \
		--shlibdir="$TERMUX_PREFIX/lib" \
		--incdir="$TERMUX_PREFIX/include" \
		--pkg-config-flags="--static" \
		--enable-gpl \
		--enable-version3 \
		--enable-nonfree \
		--disable-stripping \
		--disable-doc \
		--disable-htmlpages \
		--disable-manpages \
		--disable-podpages \
		--disable-txtpages \
		--enable-shared \
		--enable-static \
		--enable-pic \
		--enable-avcodec \
		--enable-avformat \
		--enable-avutil \
		--enable-swresample \
		--enable-swscale \
		--enable-postproc \
		--enable-avfilter \
		--enable-network \
		--enable-eia600 \
		--enable-pthreads \
		--enable-ffmpeg \
		--enable-ffplay \
		--enable-ffprobe \
		--enable-encoder=* \
		--enable-decoder=* \
		--enable-muxer=* \
		--enable-demuxer=* \
		--enable-parser=* \
		--enable-bsfs \
		--enable-protocol=* \
		--enable-filter=* \
		--enable-libmp3lame \
		--enable-libopus \
		--enable-libvorbis \
		--enable-libwebp \
		--enable-libxml2 \
		--enable-libfreetype \
		--enable-libfontconfig \
		--enable-libharfbuzz \
		--enable-openssl \
		--enable-gnutls \
		--enable-lzma \
		--enable-zlib \
		--enable-bzlib \
		--disable-sdl2 \
		--enable-pulse \
		--enable-alsa \
		--disable-libjack \
		--disable-indev=jack \
		--disable-libxcb \
		--disable-libxcb-shm \
		--disable-libxcb-xfixes \
		--disable-libxcb-shape \
		--disable-vdpau \
		--disable-vaapi \
		--disable-cuvid \
		--disable-nvenc \
		--disable-nvdec \
		--disable-libmfx \
		--disable-ffnvcodec \
		--disable-v4l2_m2m \
		--disable-libx264 \
		--disable-libx265 \
		--disable-libxvid \
		--disable-libvpx \
		--disable-libtheora \
		--disable-libass \
		--disable-libbluray \
		--disable-sndio \
		--disable-libsoxr \
		--disable-libspeex \
		--disable-opencl \
		--disable-amf \
		--host-os=linux \
		--target-os=linux \
		--cross-prefix="${TERMUX_HOST_PLATFORM}-" \
		$_extra_args
}
