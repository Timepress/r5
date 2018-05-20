add_gem 'materialize-sass', "~> 1.0.0.rc1"
add_gem 'material_icons'

run 'bundle install'
# system "yarn add jquery moment snackbarjs"

remove_file "#{@project_path}/app/assets/stylesheets/application.css"

create_file "#{@project_path}/app/assets/stylesheets/application.scss" do <<-TXT
@import "materialize/components/color-variables";
$primary-color: color("grey", "base") !default;
$secondary-color: color("green", "base") !default;
$link-color: color("green", "base") !default;
@import "materialize";
@import "material_icons";
TXT
end


insert_into_file "#{@project_path}/app/assets/javascripts/application.js",
before: "\n//= require_tree ." do <<-TXT
  \n
  //= require materialize
  //= require jquery
TXT
end
