#!/user/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exex rails assets:precompile
bundle exec rails assets:clean
bundle exec rails db:migrate