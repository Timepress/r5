run 'bundle install'

system "yarn add materialize-css jquery moment"

insert_into_file "#{@project_path}/app/assets/stylesheets/application.css",
before: "\n *= require_tree ." do <<-TXT

*= require materialize-css/dist/css/materialize
TXT
end

insert_into_file "#{@project_path}/app/assets/javascripts/application.js",
before: "\n//= require_tree ." do <<-TXT

//= require materialize-css/dist/js/materialize
//= require moment/min/moment-with-locales
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