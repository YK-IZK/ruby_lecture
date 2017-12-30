# markdown engine setting
set :markdown_engine, :kramdown
set :markdown, :fenced_code_blocks => true, :smartypants => true, :with_toc_data => true, :tables => true, :autolink => true, :gh_blockcode => true
set :markdown, input: "GFM"

set :livereload_css_target, "main"
# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

activate :syntax, line_numbers: true, start_line: 1
activate :directory_indexes
activate :livereload

# Layouts
# https://middlemanapp.com/basics/layouts/
page '/', layout: "home"

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

# proxy(
#   '/this-page-has-no-template.html',
#   '/template-file.html',
#   locals: {
#     which_fake_page: 'Rendering a fake page with a local variable'
#   },
# )

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

helpers do
  def get_current_page_title
    chapter_title = YAML.load_file("settings.yml")['lecture']['chapter_title']
    current_title = chapter_title.find { |chapter_num, title| current_path.include?("chapter#{chapter_num}") }
    current_title.nil? ? "" : "#{current_title[0]}. #{current_title[1]}"
  end

  def get_current_page_category
    current_path.split('/').first
  end

  def get_code_lang(file_name)
    case file_name
    when /.rb/
      'rb'
    when /.sh/
      'sh'
    end
  end

  def generate_code(file_name)

    File.open("source/code/#{file_name}.txt") do |file|
      return [
        "<div class=\"file-name\">#{file_name}</div>",
        "~~~#{get_code_lang(file_name)}\n#{file.read}\n~~~",
      ].join("\n")
    end
  end

  def generate_sidemenu
    chapter_titles = YAML.load_file("settings.yml")['lecture']['chapter_title']

    str = '<div class="nav flex-column nav-pills">'

    chapter_titles.each do |chapter_num, title|
      is_active = current_path.include?("chapter#{chapter_num}")
      str << "<a class=\"nav-link #{'active' if is_active}\" href=\"/lecture/chapter#{chapter_num}\">#{chapter_num}. #{title}</a>"
    end
    str << '</div>'
  end
end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

# configure :build do
#   activate :minify_css
#   activate :minify_javascript
# end
