wicked_pdf_conf = "#{@project_path}/config/initializers/wicked_pdf.rb"

return say('Wicked_pdf already installed', :red) if File.exists?(wicked_pdf_conf)

add_gem 'wicked_pdf'
add_gem 'wkhtmltopdf-binary'
run 'bundle install'
run 'rails generate wicked_pdf'

instructions = <<-TXT
INSTRUCTIONS:
Quick test: add 'render pdf: "file_name"' to your controller action
(show action is usually the easiest bet) )

More advanced example:
  footer_html = render_to_string('offers/footer.html.erb', layout: 'layouts/pdf.html')
  header_html = render_to_string('offers/header.html.erb', layout: 'layouts/pdf.html')
  body_html = render_to_string('offers/print.html.erb', layout: 'layouts/pdf.html')

  pdf = WickedPdf.new.pdf_from_string(
          body_html,
          header: {content: header_html, spacing: 5},
          footer: {content: footer_html},
          page_size: 'A4',
          margin: {top: 25, bottom: 45, left: 10, right: 10},

  )
  send_data pdf, filename: "offer_number.pdf",
            type: 'application/pdf',
            disposition: 'inline'

FOR MORE INFORMATION: https://github.com/mileszs/wicked_pdf
TXT

say instructions, :green
say "For server - find binary with which wkhtmltopdf and used it as exe_path in config/initializers/wicked_pdf.rb", :red


