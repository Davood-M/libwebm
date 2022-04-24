FROM --platform=linux/amd64 ubuntu:20.04 as builder

RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y cmake clang git

ADD . /libwebm
WORKDIR /libwebm

# build the binary
# RUN rm -rf build
# RUN mkdir build
WORKDIR build 
RUN rm CMakeCache.txt
# RUN make clean
RUN CC=clang CXX=clang++ cmake ..
RUN make

# Package
FROM --platform=linux/amd64 ubuntu:20.04

COPY --from=builder /libwebm/build/webm2ts /
