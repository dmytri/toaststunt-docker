FROM rust
ENV DEBIAN_FRONTEND=noninteractive
run apt-get -y update
RUN apt-get -y install build-essential bison gperf cmake libsqlite3-dev \
	libaspell-dev libpcre3-dev nettle-dev g++ libcurl4-openssl-dev git
RUN mkdir /app
WORKDIR /app
RUN git clone https://github.com/lisdude/toaststunt.git
RUN cd /app/toaststunt \
    && git submodule update --init \
    && cd src/dependencies/phc-winner-argon2 \
    && make \
    && make install PREFIX=/usr
RUN cd /app/toaststunt \
    && mkdir build \
    && cd build \
    && cmake ../ \
    && make -j2
COPY toastcore.db toaststunt/toastcore.db
COPY init toaststunt/init
CMD bash toaststunt/init
