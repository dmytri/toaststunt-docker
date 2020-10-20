FROM archlinux:latest
RUN pacman -Syu --noconfirm bison gperf gcc cmake aspell gettext make git
RUN mkdir /app
WORKDIR /app
RUN git clone https://github.com/lisdude/toaststunt.git \
    && cd toaststunt \
    && mkdir build \
    && cd build \
    && cmake ../ \
    && make -j2
COPY toastcore.db toaststunt/db/toastcore.db
CMD cd toaststunt \
  && build/moo db/toastcore.db db/toastcore.db.new
