#!/bin/bash

# Create an explicitly defined Gemfile.lock to force a specific version
cat > /tmp/Gemfile.lock.forced << 'EOF'
GEM
  remote: https://rubygems.org/
  specs:
    RedCloth (4.2.9)
    chunky_png (1.3.5)
    classifier (1.3.3)
      fast-stemmer (>= 1.0.0)
    compass (0.12.7)
      chunky_png (~> 1.2)
      fssm (>= 0.2.7)
      sass (~> 3.2.19)
    directory_watcher (1.5.1)
    fast-stemmer (1.0.2)
    fssm (0.2.10)
    haml (3.1.8)
    jekyll (0.12.1)
      classifier (~> 1.3)
      directory_watcher (~> 1.1)
      kramdown (~> 0.14)
      liquid (~> 2.3)
      maruku (~> 0.5)
      pygments.rb (~> 0.3.2)
    kramdown (0.14.2)
    liquid (2.3.0)
    maruku (0.7.2)
    posix-spawn (0.3.11)
    pygments.rb (0.3.7)
      posix-spawn (~> 0.3.6)
      yajl-ruby (~> 1.1.0)
    rack (1.4.7)
    rack-protection (1.5.3)
      rack
    rake (10.0.4)
    rb-fsevent (0.9.7)
    rdiscount (1.6.8)
    rubypants (0.2.0)
    sass (3.2.19)
    sinatra (1.3.6)
      rack (~> 1.4)
      rack-protection (~> 1.3)
      tilt (~> 1.3, >= 1.3.3)
    stringex (1.4.0)
    tilt (1.4.1)
    yajl-ruby (1.1.0)

PLATFORMS
  ruby

DEPENDENCIES
  RedCloth (~> 4.2.9)
  compass (~> 0.12.2)
  haml (~> 3.1.7)
  jekyll (~> 0.12)
  liquid (~> 2.3.0)
  pygments.rb (~> 0.3.4)
  rack (~> 1.4.1)
  rake (~> 10.0.3)
  rb-fsevent (~> 0.9)
  rdiscount (~> 1.6.8)
  rubypants (~> 0.2.0)
  sinatra (~> 1.3.3)
  stringex (~> 1.4.0)

BUNDLED WITH
   1.17.3
EOF

# Create a script to run inside the Docker container
cat > /tmp/run_in_docker.sh << 'EOF'
#!/bin/bash
set -e

cd /app

# Use the forced Gemfile.lock
cp /tmp/Gemfile.lock.forced Gemfile.lock

# Install dependencies
apt-get update && apt-get install -y make gcc g++ python2.7
ln -sf /usr/bin/python2.7 /usr/bin/python

# Install a compatible bundler
gem install bundler -v 1.17.3

# Install dependencies
bundle _1.17.3_ install

# Generate the site
bundle exec rake generate

# Show the generated files
echo "Site successfully generated. Files in the public directory:"
ls -la public/
EOF

chmod +x /tmp/run_in_docker.sh

# Run the Docker container with Ruby 2.0
docker run --rm -v $(pwd):/app -v /tmp/Gemfile.lock.forced:/tmp/Gemfile.lock.forced -v /tmp/run_in_docker.sh:/tmp/run_in_docker.sh ruby:2.0 /tmp/run_in_docker.sh