# Etapa 1: base con herramientas desde Debian
FROM debian:bullseye-slim as tools

RUN apt-get update && apt-get install -y \
    curl \
    bash \
    wget \
    webp \
    ffmpeg \
    jq \
    nano \
    git \
    && apt-get clean

# Etapa 2: imagen oficial de n8n
FROM n8nio/n8n:latest

USER root

# Copiar binarios útiles desde la primera imagen
COPY --from=tools /usr/bin/ /usr/bin/
COPY --from=tools /usr/lib/ /usr/lib/
COPY --from=tools /usr/share/ /usr/share/
COPY --from=tools /bin/ /bin/
COPY --from=tools /lib/ /lib/
COPY --from=tools /lib64/ /lib64/

USER node
