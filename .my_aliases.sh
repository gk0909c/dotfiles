#!/bin/bash

# about rails
alias rails-server="bundle exec rails server -b 0.0.0.0"
# use light server
alias publish-istanbul="light-server -s ./coverage/lcov-report -p 3000 -b 0.0.0.0"
alias publish-jsdoc="light-server -s ./jsdoc -p 3000 -b 0.0.0.0"
alias publish-simplecov="light-server -s ./coverage -p 3000 -b 0.0.0.0"
