run 'bundle install'
# TODO removing is probably not good idea when adding bootstrap to existing project
remove 'app/views/layouts/application.html.erb'

system "yarn add jquery bootstrap eonasdan-bootstrap-datetimepicker moment"

insert_into_file "#{@project_path}/app/assets/stylesheets/application.css",
                 before: "\n *= require_tree ." do <<-TXT
 
 *= require bootstrap/dist/css/bootstrap
 *= require eonasdan-bootstrap-datetimepicker/build/css/bootstrap-datetimepicker
TXT
end

insert_into_file "#{@project_path}/app/assets/javascripts/application.js",
                 before: "\n//= require_tree ." do <<-TXT
                 
//= require bootstrap/dist/js/bootstrap
//= require moment/min/moment-with-locales
//= require eonasdan-bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min
TXT
end

insert_into_file "#{@project_path}/app/javascript/packs/application.js",
                 after: "console.log('Hello World from Webpacker')" do <<-JS
                 
import jQuery from 'jquery'
window.jQuery = jQuery

let ready;
ready = function() {
  $(".datepicker").datetimepicker({locale: 'cs', format: 'D. M. YYYY'});
};
// Fire javascript after turbolinks event
$(document).on('turbolinks:load', ready);
JS
end

insert_into_file "#{@project_path}/config/webpack/shared.js",
                 after: "new ManifestPlugin({ fileName: paths.manifest, publicPath, writeToFileEmit: true })
  ]," do <<-JS
  
  resolve: {
    alias: {
      jquery: "jquery/src/jquery"
    }
  },
JS
end

insert_into_file "#{@project_path}/config/webpack/shared.js",
                 after: "new ExtractTextPlugin(env.NODE_ENV === 'production' ? '[name]-[hash].css' : '[name].css')," do <<-JS
  
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    jquery: 'jquery'
  }),
JS
end
