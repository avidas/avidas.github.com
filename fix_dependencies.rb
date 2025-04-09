#!/usr/bin/env ruby

# This script patches the yajl-ruby gem to work with modern Ruby versions
# It replaces rb_cFixnum with rb_cInteger in the source code

require 'fileutils'
require 'rubygems'

def find_gem_paths(name, version = nil)
  if Gem::Specification.respond_to?(:find_all_by_name)
    specs = Gem::Specification.find_all_by_name(name, version)
    specs.map { |spec| spec.full_gem_path }
  else
    []
  end
end

def patch_yajl_ruby
  puts "Searching for yajl-ruby gem..."
  
  # First try to find using Gem specification
  gem_dirs = find_gem_paths('yajl-ruby')
  
  # If that fails, try searching in common locations
  if gem_dirs.empty?
    gem_dirs = Dir.glob(File.join(ENV['GEM_HOME'] || Gem.dir, 'gems', 'yajl-ruby-*'))
    gem_dirs += Dir.glob(File.join('vendor/bundle/gems', 'yajl-ruby-*'))
    gem_dirs += Dir.glob(File.join('vendor/bundle/ruby/*/gems', 'yajl-ruby-*'))
  end
  
  if gem_dirs.empty?
    puts "Could not find yajl-ruby gem directory"
    return false
  end
  
  success = false
  
  gem_dirs.each do |gem_dir|
    puts "Checking #{gem_dir}..."
    
    # Find the yajl_ext.c file
    ext_file = File.join(gem_dir, 'ext', 'yajl', 'yajl_ext.c')
    
    if !File.exist?(ext_file)
      puts "Could not find yajl_ext.c file at #{ext_file}"
      next
    end
    
    # Read the file content
    content = File.read(ext_file)
    
    # Skip if already patched
    if !content.include?('rb_cFixnum')
      puts "File already patched or doesn't need patching"
      next
    end
    
    # Replace rb_cFixnum with rb_cInteger
    patched_content = content.gsub('rb_cFixnum', 'rb_cInteger')
    
    # Write the patched content back
    File.write(ext_file, patched_content)
    
    puts "Successfully patched yajl-ruby gem at #{gem_dir}"
    
    # Rebuild the gem
    Dir.chdir(File.join(gem_dir, 'ext', 'yajl')) do
      system('ruby extconf.rb && make clean && make')
    end
    
    success = true
  end
  
  return success
end

# Main execution
if patch_yajl_ruby
  puts "Dependency fixing completed successfully"
  exit 0
else
  puts "No dependencies were fixed"
  exit 0  # Don't exit with error to allow Docker build to continue
end