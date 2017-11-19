FROM buildpack-deps:artful
RUN apt-get update && apt-get install -y --no-install-recommends \
	capnproto \
	libcapnp-dev \
	&& rm -rf /var/lib/apt/lists/*
