FROM ruby:2.3-alpine

WORKDIR /app

# Install dependencies
RUN apk add --no-cache \
    build-base \
    git \
    python \
    nodejs

# Copy Gemfile and install dependencies
COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v '~> 1.17.3'
RUN bundle install

# Copy the rest of the application
COPY . .

# Expose the port for the web server
EXPOSE 4000

# Start the Jekyll server
CMD ["bundle", "exec", "rake", "preview"]