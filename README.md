# Mesa

[![Build Status](https://travis-ci.org/dzucconi/mesa.svg?branch=master)](https://travis-ci.org/dzucconi/mesa)

A single user wiki-like; Hypermedia API.

----

## Deploying to Heroku

This app isn't in a totally releaseable state, but if you want to deploy an instance for whatever reason:

* You'll need the Node.js buildpack for Browserify:

```
heroku buildpacks:add https://github.com/heroku/heroku-buildpack-nodejs.git
heroku buildpacks:add https://github.com/heroku/heroku-buildpack-ruby.git
```

* Setup an S3 bucket (with a CORS configuration) to support drag and drop image uploads.
* [Set relevant environment variables](https://github.com/dzucconi/mesa/blob/master/.env.sample)
* `git push heroku master`
* `heroku run rake db:migrate`
