FROM codercom/code-server:latest

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends python3 python3-pip sqlite3 \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /workspace \
    && chown -R coder:coder /workspace

USER coder
WORKDIR /workspace
