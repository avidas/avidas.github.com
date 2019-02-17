# Title: Portfolio Plugin for Jekyll
# Author: Eric Ren. Forked from Sebastian Ruiz http://sruiz.co.uk, original code by: Wern Ancheta http://anchetawern.github.com
# Description: Octopress portfolio plugin.
#

module Jekyll

  class Portfolio < Liquid::Tag

    def initialize(tag_name, id, tokens)
      super
      @project_folder = id.to_s.strip
    end

    def gen_project_list(portfolio_dir_path, portfolio_root)

      portfolio_list_html = ""
      projects = Dir.glob(portfolio_dir_path + '/*').select {|f| File.directory? f}
      projects.each do |project_path|
        index_file_path = 'index.markdown'

        Dir.chdir(project_path)

        if File.exists? index_file_path
          link = portfolio_root + "/" + File.basename(project_path)
          img_files = Dir.glob('main-*')

          project_yaml = YAML::load(File.read(index_file_path))

          brief_desc = project_yaml['brief']
          proj_title = project_yaml['title'] #assume every file has a title in YAML front matter

          # generate portfolio item html
          portfolio_list_html += '<div class="portfolio-item cf ">' +
            '<span class="portfolio-info ">' +
            '<a href="' + link + '">' +
            '<h3>'+ proj_title + '</h3>' +
            '</a>'
          if not brief_desc.nil?
            portfolio_list_html += '<p>'+ brief_desc + '</p>'
          end

          portfolio_list_html += '</span>'

          if img_files.size == 1 # each project folder should have only one main-image
            alt = proj_title + ' main image'
            img = link + '/' + img_files[0]
            portfolio_list_html += '<span><a title=main-image href="' + link + '">' +
              '<img alt="' + alt + '" src="' + img + '">' +
              '</a></span>'
          end

          portfolio_list_html += '</div>'

        end
      end
      return portfolio_list_html
    end

    def render(context)
      content = ""

      portfolio_root = context.registers[:site].config['portfolio_root']
      portfolio_dir_path = context.registers[:site].config['portfolio_path']


      if(@project_folder == "")
        content += gen_project_list(portfolio_dir_path, portfolio_root)
      else
        # generate pics for the project page
        Dir.foreach(portfolio_dir_path + "/" + @project_folder) do |filename|
          if(filename != "." && filename != "..")

            link = portfolio_root + "/" + @project_folder
            img = link + "/" + filename   #changed.
            title = File.basename(filename, File.extname(filename))

            real_title = title.sub("small-", "")

            if(title.index "small-")
              content += '<a class="screenshot" title="' + real_title + '" href="' + img + '"><img src="' + img + '"></a>'
            end
            if(title.index "main-")
              content += '<a class="screenshot" title="' + real_title + '" href="' + img + '"><img src="' + img + '"></a>' # remove if you don't need main-* image on the portfolio page.
            end
          end
        end
      end

      return content
    end
  end
end

Liquid::Template.register_tag('portfolio', Jekyll::Portfolio)