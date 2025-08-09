#!/usr/bin/env bash
set -o errexit

bundle install --without development test
bundle exec rails db:prepare
bundle exec rails assets:precompile
