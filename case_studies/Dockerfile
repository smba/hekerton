FROM debian:11.3

USER root

RUN apt update -y

# install some dependencies
RUN apt install \
    lsb-release \
    wget \
    software-properties-common \
    git \
    unzip -y

# install clang
RUN apt-get install \
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
RUN apt install  \
    build-essential \
    gettext \
    autoconf \
    autopoint \
    libtool \
    po4a -y \
    wget

# use Clang as compiler, deactivate optimizations, and specify coverage report schema
ENV CC=clang
ENV LDFLAGS='-fprofile-instr-generate="profile-foo-%p.profraw"' 
ENV CFLAGS='-fprofile-instr-generate="profile-foo-%p.profraw" -fcoverage-mapping -O0'

# build GNU xz 5.2.0
COPY . /
RUN wget https://github.com/xz-mirror/xz/archive/refs/tags/v5.2.0.zip
RUN mv v5.2.0.zip xz.zip
RUN unzip xz.zip 
RUN mv xz-5.2.0/ xz
RUN ls -lah


RUN cd xz && ./autogen.sh
RUN cd xz && ./configure --enable-static
RUN cd xz && make
#RUN make install

RUN /xz/src/xz/xz --version
RUN /xz/src/xz/.libs/xz --k Dockerfile
RUN echo 'klappt alles!!!1111elf!'
