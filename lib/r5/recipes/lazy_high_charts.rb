# TODO check for existence of it
add_gem 'lazy_high_charts'
run 'bundle install'
insert_into_file "#{@project_path}/app/assets/javascripts/application.js",
                 after: "//= require_tree .\n" do
  <<EOF
//= require highcharts/highcharts
//= require highcharts/highcharts-more
//= require highcharts/highstock

Highcharts.setOptions({
    lang: {
        decimalPoint: ',',
        thousandsSep: ' '
    }
});
EOF
end