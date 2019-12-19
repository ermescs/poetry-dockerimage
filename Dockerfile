ARG PYTHON_VERSION="3"
ARG ALPINE_VERSION=""
FROM python:${PYTHON_VERSION}-alpine${ALPINE_VERSION}

# build-base is a meta-package containing C/C++ compiler and other build tools
# Such packages are often required to install Python packages
RUN apk --update --no-cache add build-base

# Install Poetry
RUN apk add --no-cache --virtual .install-deps \
        libffi-dev \
        openssl-dev \
    && pip install poetry \
    && apk del .install-deps

# Install poetry-dynamic-versioning
RUN pip install --no-cache-dir poetry-dynamic-versioning

# Git may be required for projects whose version is managed with poetry-dynamic-versioning
RUN apk --update --no-cache add git

CMD ["poetry"]
