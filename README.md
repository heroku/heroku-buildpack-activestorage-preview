# Official Rails 5.2 Active Storage Previews Buildpack

This is an [official Heroku buildpack](https://devcenter.heroku.com/articles/language-support-policy#supported-buildpacks) to support Rails 5.2 users of [Active Storage previews](https://devcenter.heroku.com/articles/active-storage-on-heroku).  

One of the marquee features of Active Storage is the ability to use “previews” of non-image attachments. Specifically you can preview PDFs and Videos. To use this feature your application needs access to system resources that know how to work with these files. By default Rails ships with support with poppler for PDF previews, and ffmpeg for Video previews. These system dependencies are not available by default on Heroku.

If you want the ability to preview these types of files with Active Support you need to run:

```term
heroku buildpacks:add -i 1 https://github.com/heroku/heroku-buildpack-activestorage-preview
```

Once you’ve done this, you need to deploy again to get the binaries. You can verify that the dependencies are installed by running which ffmpeg on the command line. If there is no output then the operation was not performed correctly. If you see a result then the binaries are ready to be used:

```
heroku run bash
~$ which ffmpeg
/usr/local/bin/ffmpeg
```

test
