from alpine:latest
RUN apk add --no-cache curl
RUN apk add --no-cache g++
RUN apk add --no-cache make
RUN apk add --no-cache linux-headers

ENV CAPNPROTO_DL_DIR="/tmp/capnproto"
ENV CAPNPROTO_DL_FORMAT="tar.gz"
#ARG CAPNPROTO_REPO="capnproto/capnproto"
#ARG CAPNPROTO_REF="master"
#ARG CAPNPROTO_URL="https://codeload.github.com/$CAPNPROTO_REPO/$CAPNPROTO_DL_FORMAT/$CAPNPROTO_REF"
ARG CAPNPROTO_VERSION="0.6.1"
ARG CAPNPROTO_URL="https://capnproto.org/capnproto-c++-$CAPNPROTO_VERSION.$CAPNPROTO_DL_FORMAT"
ARG CAPNPROTO_MAKEFLAGS=""
RUN echo "Downloading Cap'n Proto form $CAPNPROTO_URL ..."; \
	mkdir -p "$CAPNPROTO_DL_DIR" \
	&& curl "$CAPNPROTO_URL" \
	| tar -xz -C "$CAPNPROTO_DL_DIR"
ARG CAPNPROTO_CONFIGURE_FLAGS=""
ARG CAPNPROTO_CONFIGURE_CMD="./configure \$CAPNPROTO_CONFIGURE_FLAGS"
RUN echo "Configuring Cap'n Proto source ($CAPNPROTO_CONFIGURE_CMD)..." \
	&& cd "$CAPNPROTO_DL_DIR" && if [ `ls | wc -l` == 1 ]; then cd `ls`; fi \
	&& eval "$CAPNPROTO_CONFIGURE_CMD"
ARG CAPNPROTO_BUILD_FLAGS="-j6"
ARG CAPNPROTO_BUILD_TARGET="check"
ARG CAPNPROTO_BUILD_CMD="make \$CAPNPROTO_BUILD_FLAGS \$CAPNPROTO_BUILD_TARGET"
RUN echo "Building Cap'n Proto ($CAPNPROTO_BUILD_CMD)..." \
	&& cd "$CAPNPROTO_DL_DIR" && if [ `ls | wc -l` == 1 ]; then cd `ls`; fi \
	&& eval "$CAPNPROTO_BUILD_CMD"
ARG CAPNPROTO_INSTALL_FLAGS=""
ARG CAPNPROTO_INSTALL_TARGET="install"
ARG CAPNPROTO_INSTALL_CMD="make \$CAPNPROTO_INSTALL_FLAGS \$CAPNPROTO_INSTALL_TARGET"
RUN echo "Installing Cap'n Proto ($CAPNPROTO_INSTALL_CMD)..." \
	&& cd "$CAPNPROTO_DL_DIR" && if [ `ls | wc -l` == 1 ]; then cd `ls`; fi \
	&& eval "$CAPNPROTO_INSTALL_CMD"
RUN echo "Cleaning up after Cap'n Proto installation..." \
	&& rm -rf "$CAPNPROTO_DL_DIR"
