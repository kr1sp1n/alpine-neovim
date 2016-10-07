FROM alpine:edge
MAINTAINER Krispin Schulz <krispinone@gmail.com>
ENV CMAKE_EXTRA_FLAGS=-DENABLE_JEMALLOC=OFF
RUN echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk add --update-cache --virtual build-deps --no-cache \
    curl \
    autoconf \
    automake \
    cmake \
    g++ \
    libtool \
    libuv \
    linux-headers \
    lua5.3-dev \
    m4 \
    make \
    unzip \
    libtermkey-dev \
    lua-sec

RUN apk add --update-cache \
    git \
    libtermkey \
    unibilium

RUN git clone https://github.com/neovim/libvterm.git && \
    cd libvterm && \
    make && \
    make install && \
    cd ../ && rm -rf libvterm

RUN git clone https://github.com/neovim/neovim.git nvim && \
    cd nvim && \
    make && \
    make install && \
    cd .. && \
    rm -rf nvim && \
    apk del build-deps

ENTRYPOINT /usr/local/bin/nvim
