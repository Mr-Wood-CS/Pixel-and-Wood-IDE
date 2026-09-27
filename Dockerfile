FROM codercom/code-server:latest

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends python3 python3-pip sqlite3 \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /workspace \
    && chown -R coder:coder /workspace

COPY --chown=coder:coder extensions/pixelwood-python-runner-1.4.2.vsix /tmp/pixelwood-python-runner.vsix

USER coder

RUN code-server --install-extension /tmp/pixelwood-python-runner.vsix --force \
    && rm /tmp/pixelwood-python-runner.vsix

WORKDIR /workspace
