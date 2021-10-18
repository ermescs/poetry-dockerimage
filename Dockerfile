ARG PYTHON_VERSION="3.7.12"
ARG DEBIAN_VERSION="bullseye"
FROM python:${PYTHON_VERSION}-slim-${DEBIAN_VERSION}

# Add GIT (required for Poetry Dynamic Versioning)
RUN apt update && apt install git -y

# Update PIP
RUN pip install --upgrade pip

# Install Poetry
ARG POETRY_VERSION="1.1.11"
RUN pip install poetry==${POETRY_VERSION}

# Install poetry-dynamic-versioning
RUN pip install --no-cache-dir poetry-dynamic-versioning

CMD ["poetry"]
