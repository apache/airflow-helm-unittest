# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

ARG ALPINE_VERSION="3.12"

FROM alpine:${ALPINE_VERSION}

ARG HELM_VERSION
ARG HELMUNITTEST_VERSION
ARG AIRFLOW_HELMUNITTEST_VERSION
ARG COMMIT_SHA

COPY plugin.yaml install-binary.sh unittest go.mod main.go /


RUN apk add --no-cache ca-certificates bash git openssh curl \
    && wget -q https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - \
        | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm \
    && helm plugin install .

LABEL org.apache.airflow.component="helm-unittest"
LABEL org.apache.airflow.airflow_helm_unittest.version="${AIRFLOW_HELMUNITTEST_VERSION}"
LABEL org.apache.airflow.helm_unittest.version="${HELMUNITTEST_VERSION}"
LABEL org.apache.airflow.helm.version="${HELM_VERSION}"
LABEL org.apache.airflow.commit_sha="${COMMIT_SHA}"

CMD bash

