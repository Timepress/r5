wicked_pdf_conf = "#{@project_path}/config/initializers/wicked_pdf.rb"

return say('Wicked_pdf already installed', :red) if File.exists?(wicked_pdf_conf)

add_gem 'wicked_pdf'
add_gem 'wkhtmltopdf-binary'
run 'bundle check && bundle install'
run 'rails generate wicked_pdf'


insert_into_file wicked_pdf_conf,
                 after: "# https://github.com/mileszs/wicked_pdf/blob/master/README.md\n" do
<<RUBY
require 'wicked_pdf'
require 'rbconfig'

if RbConfig::CONFIG['host_os'] =~ /linux/
  arch = RbConfig::CONFIG['host_cpu'] == 'x86_64' ? 'wkhtmltopdf_linux_amd64' : 'wkhtmltopdf_linux_386'
elsif RbConfig::CONFIG['host_os'] =~ /darwin/
  arch = 'wkhtmltopdf_darwin_386'
else
  raise "Invalid platform. Must be running Intel-based Linux or OSX."
end
RUBY
end


gsub_file wicked_pdf_conf, "# exe_path: Gem.bin_path('wkhtmltopdf-binary', 'wkhtmltopdf')" do
<<RUBY
    exe_path: "\#{ENV['GEM_HOME']}/gems/wkhtmltopdf-binary-\#{Gem.loaded_specs['wkhtmltopdf-binary'].version}/bin/\#{arch}"
RUBY

end

say "CHECK https://github.com/mileszs/wicked_pdf", :green
say "In case you get error 'Bad wkhtmltopdf path' - find binary with which wkhtmltopdf and used it as exe_path in config/initializers/wicked_pdf.rb", :red


