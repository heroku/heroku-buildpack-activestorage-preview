# Official Rails 5.2 Active Storage Previews Buildpack

This is an [official Heroku buildpack](https://devcenter.heroku.com/articles/language-support-policy#supported-buildpacks) to support Rails 5.2 users of [Active Storage previews](https://devcenter.heroku.com/articles/active-storage-on-heroku).

One of the marquee features of Active Storage is the ability to use “previews” of non-image attachments. Specifically you can preview PDFs and Videos. To use this feature your application needs access to system resources that know how to work with these files. By default Rails ships with support for two PDF libraries, one of which is available on Heroku, and it can use FFMPEG for Video previews, which is not available by default on Heroku.

If you want the ability to preview video files with Active Support you need to run:

```term
heroku buildpacks:add -i 1 https://github.com/heroku/heroku-buildpack-activestorage-preview
```

Once you’ve done this, you need to deploy again to get the binaries. You can verify that the dependencies are installed by running `which ffmpeg` on the command line. If there is no output then the operation was not performed correctly. If you see a result then the binaries are ready to be used:

```
heroku run bash
~$ which ffmpeg
/app/.heroku/activestorage-preview/bin/ffmpeg
```

## FFMPEG Versions

| Stack     | FFMPEG Version |
|-----------|---------------:|
| heroku-20 | 5.1.6 |
| heroku-22 | 5.1.6 |
| heroku-24 | 7.1.1 |

## Development

### Binaries

Instructions for building binaries (currently only FFMPEG) can be found in [build/README.md](build/README.md).

### Versioning

The main branch is stable. Each commit is a stand alone version.
