FROM alpine:3.12.0

ENV HELM_VERSION="v3.1.2"

RUN apk add --no-cache ca-certificates bash git openssh curl \
    && wget -q https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    && helm plugin install https://github.com/aneesh-joseph/helm-unittest

CMD bash
