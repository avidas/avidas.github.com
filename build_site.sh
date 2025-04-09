#!/bin/bash

# Create a temporary Dockerfile specifically for building the site
cat > Dockerfile.build << 'EOF'
FROM ruby:2.7-slim

WORKDIR /app

# Install build dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    nodejs \
    python2.7

# Create a python symlink
RUN ln -s /usr/bin/python2.7 /usr/bin/python

# Copy application files
COPY . .

# Install gems needed for simple static site generation
RUN gem install rake -v '~> 10.0.3' \
    && gem install rdiscount -v '~> 1.6.8' \
    && gem install liquid -v '~> 2.3.0' \
    && gem install pygments.rb -v '~> 0.3.4' \
    && gem install jekyll -v '~> 0.12.0' \
    && gem install yajl-ruby -v '1.4.3'

# Generate the site
CMD ["rake", "generate"]
EOF

# Build the Docker image
docker build -t octopress-builder -f Dockerfile.build .

# Run the container to generate the site
docker run --rm -v $(pwd):/app octopress-builder

# Cleanup
rm Dockerfile.build

echo "Site generation complete. Check the 'public' directory for the generated site."