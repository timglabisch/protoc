FROM rust:latest AS builder
WORKDIR /usr/src/
RUN apt update && \
    apt install -y protobuf-compiler cmake && \
    rustup target add x86_64-unknown-linux-musl 
ADD . /code
RUN cd /code && cargo build --release


FROM ubuntu:latest
COPY --from=builder /code/target/release/protogen /protogen
RUN apt update && apt-get install -y git build-essential autoconf libtool pkg-config cmake 
RUN cd /tmp \ 
    && git clone -b v1.46.3 --depth 1 https://github.com/grpc/grpc \
    && cd grpc && \
    git submodule update --init && \
    mkdir -p cmake/build && \
    cd cmake/build && cmake ../.. && make protoc grpc_php_plugin && make install