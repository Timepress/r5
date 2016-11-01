FileUtils.rm_rf("#{@project_path}/lib/templates")
my_directory 'lib/templates'
insert_into_file "#{@project_path}/app/assets/javascripts/application.js",
                 after: "//= require jquery_ujs\n" do <<-TXT
  //= require jquery-ui/datepicker
  TXT
end

copy 'config/initializers/time_formats.rb'

insert_into_file "#{@project_path}/app/assets/stylesheets/application.css",
                 before: "\n *= require_tree ." do <<-TXT
   *= require jquery-ui/datepicker
TXT
end

create_file "#{@project_path}/app/assets/javascripts/custom.js.erb" do
  <<-JS
    var ready;
    ready = function() {
      $(".datepicker").datepicker({ dateFormat: 'dd. mm. yy'});
    };
    // Fire javascript after turbolinks event
    $(document).on('turbolinks:load', ready);
  JS
end
