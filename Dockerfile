FROM rust:latest AS builder
WORKDIR /usr/src/
RUN apt update && \
    apt install -y protobuf-compiler cmake && \
    rustup target add x86_64-unknown-linux-musl 
ADD . /code
RUN cd /code && cargo build --release


FROM ubuntu:latest
COPY --from=builder /code/target/release/protogen /protogen
RUN apt update && apt install -y protobuf-compiler