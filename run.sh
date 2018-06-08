#!/usr/bin/env bash

#bundle exec rainbows -c config/rainbows.rb -E production -D
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

bundle exec unicorn -c config/unicorn.rb -E production -D
#RACK_ENV=production bundle exec ruby tools/recorder.rb restart