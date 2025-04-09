#!/bin/bash

# Create a script to run inside the Docker container
cat > /tmp/complex_build_script.sh << 'EOF'
#!/bin/bash
set -ex

cd /app

# Install build dependencies
apt-get update && apt-get install -y make gcc g++ python2.7 libssl-dev git curl
ln -sf /usr/bin/python2.7 /usr/bin/python

# Install a compatible bundler
gem install bundler -v 1.17.3

# Manually download, patch and install yajl-ruby
git clone https://github.com/brianmario/yajl-ruby.git /tmp/yajl-ruby
cd /tmp/yajl-ruby
git checkout v1.1.0
sed -i 's/rb_cFixnum/rb_cInteger/g' ext/yajl/yajl_ext.c
gem build yajl-ruby.gemspec
gem install yajl-ruby-1.1.0.gem

# Go back to app directory
cd /app

# Manually install other dependencies
gem install rake -v 10.0.4
gem install rack -v 1.4.7
gem install rdiscount -v 1.6.8
gem install RedCloth -v 4.2.9
gem install liquid -v 2.3.0
gem install maruku -v 0.7.0
gem install posix-spawn -v 0.3.11
gem install directory_watcher -v 1.5.1
gem install classifier -v 1.3.3
gem install pygments.rb -v 0.3.7
gem install kramdown -v 0.14.2
gem install jekyll -v 0.12.1
gem install haml -v 3.1.8
gem install compass -v 0.12.7
gem install rubypants -v 0.2.0
gem install rb-fsevent -v 0.9.7
gem install stringex -v 1.4.0
gem install sinatra -v 1.3.6
gem install sass -v 3.2.19
gem install fssm -v 0.2.10
gem install chunky_png -v 1.3.5

# Generate the site (ignore any missing dependencies warnings)
cd /app
bundle exec rake generate || rake generate

# Show the generated files
echo "Site successfully generated. Files in the public directory:"
ls -la public/
EOF

chmod +x /tmp/complex_build_script.sh

# Run the Docker container with Ruby 2.6 (more compatible with older gems than 2.7)
docker run --rm -v $(pwd):/app -v /tmp/complex_build_script.sh:/tmp/complex_build_script.sh ruby:2.6 /tmp/complex_build_script.sh