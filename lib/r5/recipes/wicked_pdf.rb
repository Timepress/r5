wicked_pdf_conf = "#{@project_path}/config/initializers/wicked_pdf.rb"

return say('Wicked_pdf already installed', :red) if File.exists?(wicked_pdf_conf)

add_gem 'wicked_pdf'
add_gem 'wkhtmltopdf-binary'
run 'bundle install'
run 'rails generate wicked_pdf'

say "CHECK https://github.com/mileszs/wicked_pdf", :green
say "For server - find binary with which wkhtmltopdf and used it as exe_path in config/initializers/wicked_pdf.rb", :red


