FROM debian
RUN apt-get update && apt-get install -y --no-install-recommends \
	capnproto \
	&& rm -rf /var/lib/apt/lists/*
