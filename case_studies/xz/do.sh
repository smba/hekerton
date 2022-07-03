#!/bin/bash

rm -rf xz/

## install some dependencies
sudo apt install \
    lsb-release \
    wget \
    software-properties-common \
    git \
    unzip -y

# install clang
sudo apt-get install \
    clang-format \
    clang-tidy \
    clang-tools \
    clang clangd \
    libc++-dev \
    libc++1 \
    libc++abi-dev \
    libc++abi1 \
    libclang-dev \
    libclang1 \
    liblldb-dev \
    libllvm-ocaml-dev \
    libomp-dev \
    libomp5 \
    lld \
    lldb \
    llvm-dev \
    llvm-runtime \
    llvm \
    python3-clang -y

# install dependencies for GNU xz
sudo apt install  \
    build-essential \
    gettext \
    autoconf \
    autopoint \
    libtool \
    po4a -y \
    wget

# use Clang as compiler, deactivate optimizations, and specify coverage report schema
export CC=$(which clang)
export LDFLAGS='-fprofile-instr-generate="profile-foo-%p.profraw"'
export CFLAGS='-fprofile-instr-generate="profile-foo-%p.profraw" -fcoverage-mapping -O0'

    # build GNU xz 5.2.0

wget https://github.com/xz-mirror/xz/archive/refs/tags/v5.2.0.zip
mv v5.2.0.zip xz.zip
unzip xz.zip
mv xz-5.2.0/ xz
ls -lah


cd xz
./autogen.sh
./configure --enable-static
make
    #RUN make install
llvm-profdata merge --sparse profile-foo-96240.profraw -o cov.profdata
llvm-cov export --format=text --instr-profile cov.profdata xzz > bener.json

llvm-cov show --instr-profile cov.profdata xzz > cov.txt
