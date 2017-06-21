#!/bin/bash

# about bundle
alias be-rake="bundle exec rake "
alias be-rails="bundle exec rails "
alias be-rspec="bundle exec rspec "

# about rails
alias rails-server="bundle exec rails server -b 0.0.0.0 -d"
alias rails-server-f="bundle exec rails server -b 0.0.0.0"
alias kill-rails-server='kill `cat tmp/pids/server.pid`'

# use light server
alias publish-istanbul="light-server -s ./coverage/lcov-report -p 3000 -b 0.0.0.0"
alias publish-jsdoc="light-server -s ./jsdoc -p 3000 -b 0.0.0.0"
alias publish-simplecov="light-server -s ./coverage -p 3000 -b 0.0.0.0"

# ctags
alias ctags-gen-rails='ctags --langmap=RUBY:.rb --exclude="*.js"  --exclude=".git*" -R'
