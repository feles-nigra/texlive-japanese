FROM alpine:latest

ENV PATH=/usr/local/texlive/2024/bin/x86_64-linuxmusl:$PATH

RUN apk add --no-cache curl perl fontconfig-dev freetype-dev graphviz python3 openjdk11 inkscape&& \
    apk add --no-cache --virtual .fetch-deps xz tar wget && \
    mkdir /tmp/install-tl-unx && \
    curl -L ftp://tug.org/historic/systems/texlive/2024/install-tl-unx.tar.gz | \
      tar -xz -C /tmp/install-tl-unx --strip-components=1 && \
    printf "%s\n" \
      "selected_scheme scheme-basic" \
      "tlpdbopt_install_docfiles 0" \
      "tlpdbopt_install_srcfiles 0" \
      > /tmp/install-tl-unx/texlive.profile && \
    /tmp/install-tl-unx/install-tl \
      --profile=/tmp/install-tl-unx/texlive.profile && \
    tlmgr install \
      collection-basic \
      collection-latex \
      collection-latexrecommended \
      collection-latexextra \
      collection-fontsrecommended \
      collection-langjapanese \
      pythontex \
      luatex85 \
      plantuml \
      latexmk && \
    rm -fr /tmp/install-tl-unx && \
    apk del .fetch-deps


WORKDIR /workdir

RUN adduser -D -u 1000 latexuser
RUN chown -R latexuser:latexuser /workdir
USER latexuser

COPY ./tex2pdf.sh /

CMD ["sh"]
