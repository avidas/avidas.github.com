#!/bin/bash

# This script attempts to generate the site in several ways,
# falling back to simpler methods if previous ones fail

echo "Attempting to generate the site using several methods..."

# Method 1: Try with the current Ruby environment
echo "Method 1: Using current Ruby environment..."
bundle install && bundle exec rake generate
if [ $? -eq 0 ]; then
  echo "Success! Site generated in 'public' directory."
  exit 0
fi

# Method 2: Try with Docker (requires Docker to be installed)
echo "Method 2: Using Docker..."
if command -v docker &> /dev/null; then
  docker run --rm -v $(pwd):/app -w /app ruby:2.7 bash -c "gem install bundler -v 1.17.3 && bundle install && bundle exec rake generate"
  if [ $? -eq 0 ]; then
    echo "Success! Site generated in 'public' directory."
    exit 0
  fi
fi

echo "Failed to generate site. See README.debugging for more information."
exit 1