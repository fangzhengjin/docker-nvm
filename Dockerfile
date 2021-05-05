FROM bitnami/bitnami-shell:10
LABEL maintainer "fangzhengjin <fangzhengjin@gmail.com>"

ENV NVM_VERSION="v0.38.0" \
    NVM_NODEJS_ORG_MIRROR="https://npm.taobao.org/mirrors/node" \
    NVM_IOJS_ORG_MIRROR="https://npm.taobao.org/mirrors/iojs" \
    ELECTRON_MIRROR="https://npm.taobao.org/mirrors/electron/" \
    ELECTRON_BUILDER_BINARIES_MIRROR="https://npm.taobao.org/mirrors/electron-builder-binaries/" \
    SASS_BINARY_SITE="https://npm.taobao.org/mirrors/node-sass" \
    PYTHON_MIRROR="https://npm.taobao.org/mirrors/python"

RUN install_packages ca-certificates gnupg && \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh | bash && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    install_packages yarn && \
    apt-get --purge autoremove -y gnupg && \
    ln -sf $HOME/.nvm/nvm.sh /etc/profile.d/nvm.sh && \
    printf "%b" '#!'"/usr/bin/env sh\n \
    exec /bin/sh -l -c \"\$*\"\n \
    " >/entry.sh && chmod +x /entry.sh

ENTRYPOINT ["/entry.sh"]

CMD ["nvm"]
