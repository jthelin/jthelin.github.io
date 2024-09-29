#!/bin/bash

# https://help.github.com/en/articles/setting-up-your-github-pages-site-locally-with-jekyll#step-4-build-your-local-jekyll-site

unset JEKYLL_GITHUB_TOKEN

/usr/local/opt/ruby/bin/bundle exec jekyll serve

