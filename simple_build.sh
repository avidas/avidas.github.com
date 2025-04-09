#!/bin/bash

# Create a simple script to run inside the docker container
cat > /tmp/simple_build.sh << 'EOF'
#!/bin/bash
set -e

cd /app

# Install dependencies
apt-get update && apt-get install -y python make gcc libc6-dev

# First try to generate without bundle
echo "Trying to generate site directly with rake..."
rake generate

# If that fails, try installing what we need manually
if [ $? -ne 0 ]; then
  echo "Trying to manually install dependencies..."
  
  gem install rake -v '~> 10.0'
  gem install rdiscount -v '~> 1.6.8'
  gem install liquid -v '~> 2.3.0'
  
  echo "Trying to generate site again..."
  rake generate
fi

# Show the generated files
echo "Site generation complete. Files in public directory:"
ls -la public/
EOF

chmod +x /tmp/simple_build.sh

# Run the Docker container with Ruby 2.3
docker run --rm -v $(pwd):/app -v /tmp/simple_build.sh:/tmp/simple_build.sh ruby:2.3 bash /tmp/simple_build.sh