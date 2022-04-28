FROM gcc:11.2-bullseye as builder

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    libpoppler-glib-dev \
    libwxgtk3.0-gtk3-dev \
  && apt-get -y clean \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /diff-pdf
RUN git clone --depth=1 https://github.com/vslavik/diff-pdf.git .\
  && ./bootstrap \
  && ./configure \
  && make


FROM debian:bullseye-slim
LABEL maintainer="hasegawa@hubsys.co.jp"

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    libpoppler-glib-dev \
    libwxgtk3.0-gtk3-dev \
    poppler-utils \
    poppler-data \
  && apt-get -y clean \
  && rm -rf /var/lib/apt/lists/*

COPY --from=builder /diff-pdf/diff-pdf /usr/bin/
COPY LICENSE README.md /
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
