# Building Packages

This subdirectory contains `Dockerfile`s for building binaries (currently only FFMPEG).

## Building the Image

**After every change to your formulae, perform the following** from this `build/` subdirectory to rebuild the images for each stack:

    docker build --pull --tag heroku-activestorage-preview-build-heroku-22 --file heroku-22.Dockerfile .
    docker build --pull --tag heroku-activestorage-preview-build-heroku-20 --file heroku-20.Dockerfile .
    docker build --pull --tag heroku-activestorage-preview-build-heroku-18 --file heroku-18.Dockerfile .

## Configuration

File `env.default` contains a list of required env vars, some with default values. You can copy this file to a location outside the buildpack and modify it with the values you desire and pass its location with `--env-file`, or pass the env vars to `docker run` using `--env`.

Out of the box, each `Dockerfile` has the correct values predefined for `S3_BUCKET`, `S3_PREFIX`, and `S3_REGION`. If you're building your own packages, you'll likely want to change `S3_BUCKET` and `S3_PREFIX` to match your info. Instead of setting `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` into that file, it is recommended to pass them to `docker run` through the environment, or explicitly using `--env`, in order to prevent accidental commits of credentials.

## Using the Image

You can e.g. `bash` into each of the images you built using their tag:

    docker run --rm -ti heroku-activestorage-preview-build-heroku-22 bash
    docker run --rm -ti heroku-activestorage-preview-build-heroku-20 bash
    docker run --rm -ti heroku-activestorage-preview-build-heroku-18 bash

You then have a shell where you can run `bob build` and so forth. You can of course also invoke these programs directly with `docker run`.

### Passing AWS credentials to the container

If you want to deploy packages and thus need to pass `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`, you can either pass them explicitly, through your environment, or through an env file.

Depending on your AWS/IAM/S3 setup, you might also have to expose the AWS session token using environment variable `AWS_SECURITY_TOKEN` (**not** `AWS_SESSION_TOKEN`).

#### Passing credentials explicitly

    docker run --rm -ti -e AWS_ACCESS_KEY_ID=... -e AWS_SECRET_ACCESS_KEY=... heroku-activestorage-preview-build-heroku-22 bash

#### Passing credentials through  the environment

*This is the recommended approach for setups where the secrets are already available as environment variables, e.g. on CI setups, GitHub Actions, GitHub Codespaces etc.*

The environment variables `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` and `AWS_SECURITY_TOKEN` are defined in `env.default`, without values. This will cause Docker to "forward" values for these variables from the current environment, so you can pass them in:

    AWS_ACCESS_KEY_ID=... AWS_SECRET_ACCESS_KEY=... AWS_SECURITY_TOKEN= docker run --rm -ti --env-file=env.default heroku-activestorage-preview-build-heroku-22 bash

or

    export AWS_ACCESS_KEY_ID=...
    export AWS_SECRET_ACCESS_KEY=...
    export AWS_SECURITY_TOKEN=...
    docker run --rm -ti --env-file=env.default heroku-activestorage-preview-build-heroku-22 bash

#### Passing credentials through a separate env file

This method is the easiest for users who want to build packages in their own S3 bucket, as they will have to adjust the `S3_BUCKET` and `S3_PREFIX` environment variable values anyway from their default values.

For this method, it is important to keep the credentials file in a location outside the buildpack, so that your credentials aren't accidentally committed. Copy `env.default` **to a safe location outside the buildpack directory**, and insert your values for `AWS_ACCESS_KEY_ID`and `AWS_SECRET_ACCESS_KEY` (and possibly `AWS_SECURITY_TOKEN`).

    docker run --rm -ti --env-file=../SOMEPATHOUTSIDE/s3.env heroku-activestorage-preview-build-heroku-22 bash

## Building specific packages

To build and upload to S3, run `bob deploy`. To only build, run `bob build` (this is really only useful inside a `docker run … bash` session, so one can inspect the resulting build).

### FFMPEG

*You need to pass in the necessary `AWS_` and `S3_` env vars using `--env-file` or `--env`.*

    docker run --rm -ti heroku-activestorage-preview-build-heroku-22 bob deploy ffmpeg-5.1.2
    docker run --rm -ti heroku-activestorage-preview-build-heroku-20 bob deploy ffmpeg-5.1.2
    docker run --rm -ti heroku-activestorage-preview-build-heroku-18 bob deploy ffmpeg-5.1.2

The package uses `libaom`, `libdav1d` and `libsvtav1enc` if available.
