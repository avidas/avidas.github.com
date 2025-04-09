# Claude Guide for Repository

## Build/Deploy Commands
- `bundle install` - Install dependencies
- `rake install` - Initial Octopress setup
- `rake generate` - Generate Jekyll site
- `rake preview` - Preview site locally at localhost:4000
- `rake watch` - Watch for changes and regenerate
- `rake deploy` - Deploy website (to GitHub Pages)
- `rake new_post["Post Title"]` - Create a new blog post
- `rake new_page["Page Title"]` - Create a new page
- `rake clean` - Clean caches (.pygments-cache, .gist-cache, .sass-cache)

## Code Style Guidelines
- **Markdown**: Use standard markdown for content (.markdown extension)
- **Front Matter**: Include layout, title, date, comments at minimum
- **HTML**: Use semantic HTML5 elements
- **CSS**: Follow Compass/SCSS conventions
- **Ruby**: Standard Ruby conventions (2-space indentation)
- **Error Handling**: Use Octopress standard exception handling
- **Images**: Place in /source/images/ directory
- **Plugins**: Custom plugins in /plugins/ directory
- **Naming**: Use kebab-case-for-files.markdown
- **Asset Management**: Use /source/assets/ for non-image assets