FROM heroku/heroku:18-build.v97

WORKDIR /app
ENV WORKSPACE_DIR=/app
ENV S3_BUCKET=heroku-activestorage-default
ENV S3_PREFIX=dist-heroku-18/
ENV S3_REGION=s3.us-east-1
ENV STACK=heroku-18
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y python3-pip

# FIXME: these needs to go on the stack image (and then FROM at the top needs version bumping)
RUN apt-get install -y --no-install-recommends gir1.2-harfbuzz-0.0 libass9 libfreetype6 libfribidi0 libgraphite2-3 libgnutls30 libharfbuzz-gobject0 libharfbuzz-icu0 libharfbuzz0b libmp3lame0 libogg0 libunistring2 libvorbis0a libvorbisenc2 libvorbisfile3 zlib1g libnuma1 libopus0 libx264-152 libx265-146 libvpx5 libopencore-amrnb0 libopencore-amrwb0 libspeex1

COPY requirements.txt /app/requirements.txt

RUN pip3 install -r /app/requirements.txt

COPY . /app
