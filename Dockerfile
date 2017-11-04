from alpine:latest
RUN apk add --no-cache curl
RUN apk add --no-cache g++
RUN apk add --no-cache make
RUN apk add --no-cache linux-headers

ENV CAPNPROTO_DL_DIR="/tmp/capnproto"
ENV CAPNPROTO_DL_FORMAT="tar.gz"
ARG CAPNPROTO_INSTALL_CMD="./configure \$CAPNPROTO_CONFIGURE_FLAGS && make -j6 \$CAPNPROTO_MAKEFLAGS check && make \$CAPNPROTO_MAKEFLAGS install"
#ARG CAPNPROTO_REPO="capnproto/capnproto"
#ARG CAPNPROTO_REF="master"
#ARG CAPNPROTO_URL="https://codeload.github.com/$CAPNPROTO_REPO/$CAPNPROTO_DL_FORMAT/$CAPNPROTO_REF"
ARG CAPNPROTO_VERSION="0.6.1"
ARG CAPNPROTO_URL="https://capnproto.org/capnproto-c++-$CAPNPROTO_VERSION.$CAPNPROTO_DL_FORMAT"
ARG CAPNPROTO_CONFIGURE_FLAGS=""
ARG CAPNPROTO_MAKEFLAGS=""
RUN echo "Downloading and installing Cap'n Proto form $CAPNPROTO_URL ..."; \
	mkdir -p "$CAPNPROTO_DL_DIR" \
	&& curl "$CAPNPROTO_URL" \
	| tar -xz -C "$CAPNPROTO_DL_DIR" \
	&& PREVDIR="$PWD" && cd "$CAPNPROTO_DL_DIR" && if [ `ls | wc -l` == 1 ]; then cd `ls`; fi \
	&& echo "Executing \`$CAPNPROTO_INSTALL_CMD\`..." \
	&& eval "$CAPNPROTO_INSTALL_CMD" \
	&& cd "$PREVDIR" && rm -rf "$CAPNPROTO_DL_DIR"
