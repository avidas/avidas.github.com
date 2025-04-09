# Resolving the Bundle Install Error

The error you're experiencing with `bundle install` is related to the `yajl-ruby` gem which has a compatibility issue with modern Ruby versions. This site uses Octopress, which is based on an older version of Jekyll (0.12.x) that has several dependencies with native extensions that are difficult to compile on modern systems.

## What's Happening

When trying to install the dependencies with `bundle install`, the `yajl-ruby` gem fails to build its native extension because it references `rb_cFixnum` which has been removed in newer versions of Ruby (it's now `rb_cInteger`).

## Solutions

### Solution 1: Use a Docker Container

The most reliable approach is to use a Docker container with Ruby 1.9.3 or 2.3:

```bash
# Create a one-time Docker container to generate the site
docker run --rm -v $(pwd):/app -w /app ruby:2.7 bash -c "gem install bundler -v 1.17.3 && bundle _1.17.3_ install && bundle exec rake generate"
```

### Solution 2: Install a Specific Ruby Version with rbenv

If you'd prefer not to use Docker:

1. Install Ruby 1.9.3 or 2.3 using rbenv:
   ```bash
   rbenv install 2.3.8
   rbenv local 2.3.8
   ```

2. Install the correct bundler version:
   ```bash
   gem install bundler -v '~> 1.17.3'
   ```

3. Install dependencies and generate the site:
   ```bash
   bundle install
   bundle exec rake generate
   ```

### Solution 3: Use the Provided Script

We've created a script that tries multiple methods to generate the site:

```bash
./generate_site.sh
```

## Long-term Solution

For a long-term solution, consider migrating to a more modern static site generator like the current version of Jekyll, Hugo, or Eleventy. This would require migrating your content and themes, but would avoid these compatibility issues going forward.

If you want to continue using Jekyll, follow the [Jekyll migration guide](https://jekyllrb.com/docs/upgrading/) to upgrade to a current version.