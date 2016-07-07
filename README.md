[![Build Status](https://travis-ci.org/ministryofjustice/prisoners-api.svg?branch=master)](https://travis-ci.org/ministryofjustice/prisoners_api)
[![Code Climate](https://codeclimate.com/github/ministryofjustice/prisoners_api/badges/gpa.svg)](https://codeclimate.com/github/ministryofjustice/prisoners_api)
[![Test Coverage](https://codeclimate.com/github/ministryofjustice/prisoners_api/badges/coverage.svg)](https://codeclimate.com/github/ministryofjustice/prisoners_api/coverage)

# Prisoners API

Initial Prisoners API microservice Rails app. Set up with Doorkeeper OAuth2 provider for [two-legged](https://github.com/doorkeeper-gem/doorkeeper/wiki/Client-Credentials-flow) auth.

Instructions:

`ADMIN_EMAIL=example@example.com ADMIN_PASSWORD=password123 rake db:create db:migrate db:seed`

Replace `ADMIN_EMAIL` and `ADMIN_PASSWORD` with preferred values.

To import sample records:

`bundle exec rake import:sample`

Navigate to http://localhost:3000

Sign in with:

Email: example@example.com

Password: password

Select one of the sample applications and click "Get access token." The returned JSON contains the access token.

Once the access token has been obtained you can make requests to the `/api/prisoners` and `/api/prisoners/<ID>` endpoints passing the access token in the header or as a request param.

An accept header containing the API version can be passed, currently this defaults to version 1 if not passed.
