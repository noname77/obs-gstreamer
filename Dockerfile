FROM registry.gitlab.com/fzwoch/obs-gstreamer/macos

ENV MACOSX_DEPLOYMENT_TARGET=14.0
ENV GSTREAMER_VERSION=1.24.7
ENV GLIB_VERSION=2.80.4

COPY . /

RUN echo "[binaries]" >> cross.txt \
  && echo "c = 'aarch64-apple-darwin23-cc'" >> cross.txt \
  && echo "cpp = 'aarch64-apple-darwin23-c++'" >> cross.txt \
  && echo "ar = 'aarch64-apple-darwin23-ar'" >> cross.txt \
  && echo "strip = 'aarch64-apple-darwin23-strip'" >> cross.txt \
  && echo "pkgconfig = 'aarch64-apple-darwin23-pkg-config'" >> cross.txt \
  && echo "[host_machine]" >> cross.txt \
  && echo "system = 'darwin'" >> cross.txt \
  && echo "cpu_family = 'aarch64'" >> cross.txt \
  && echo "cpu = 'aarch64'" >> cross.txt \
  && echo "endian = 'little'" >> cross.txt

RUN mkdir -p /opt/homebrew/Cellar/gstreamer /opt/homebrew/Cellar/glib \
  && ln -s /homebrew-libs/gstreamer-${GSTREAMER_VERSION} /opt/homebrew/Cellar/gstreamer/${GSTREAMER_VERSION} \
  && ln -s /homebrew-libs/glib-${GLIB_VERSION} /opt/homebrew/Cellar/glib/${GLIB_VERSION}

RUN export C_INCLUDE_PATH=/:/opt/homebrew/Cellar/gstreamer/${GSTREAMER_VERSION}/include/gstreamer-1.0:/opt/homebrew/Cellar/glib/${GLIB_VERSION}/include/glib-2.0:/opt/homebrew/Cellar/glib/${GLIB_VERSION}/lib/glib-2.0/include \
  && export LIBRARY_PATH=/OBS-arm64/OBS.app/Contents/Frameworks \
  && export ARCHS=arm64 && export VALID_ARCHS=arm64 \
  && meson --buildtype release --cross-file cross.txt macos-aarch64 \
  && ninja -C macos-aarch64
