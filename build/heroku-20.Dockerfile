FROM heroku/heroku:20-build.v127

WORKDIR /app
ENV WORKSPACE_DIR=/app
ENV S3_BUCKET=heroku-activestorage-default
ENV S3_PREFIX=dist_heroku-20_amd64/
ENV S3_REGION=us-east-1
ENV STACK=heroku-20
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y python3-pip python3-venv

ENV VIRTUAL_ENV=/app/.venv
RUN python3 -m venv "$VIRTUAL_ENV"

ENV PATH="$VIRTUAL_ENV/bin:$PATH"

COPY requirements.txt /app/requirements.txt

RUN pip install -r /app/requirements.txt

COPY . /app
