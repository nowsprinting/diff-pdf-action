FROM gcc:12.2.0-bullseye as builder
ARG REPO_URL=https://github.com/vslavik/diff-pdf.git
ARG REPO_REF=master

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    libpoppler-glib-dev \
    libwxgtk3.0-gtk3-dev \
  && apt-get -y clean \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /diff-pdf
RUN git clone --depth=1 --branch $REPO_REF $REPO_URL .\
  && ./bootstrap \
  && ./configure \
  && make


FROM debian:bullseye-slim
LABEL maintainer="@nowsprinting"

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    libpoppler-glib8 \
    libwxgtk3.0-gtk3-0v5 \
    poppler-data \
  && apt-get -y clean \
  && rm -rf /var/lib/apt/lists/*

COPY --from=builder /diff-pdf/diff-pdf /usr/bin/
COPY LICENSE README.md entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["--help"]
