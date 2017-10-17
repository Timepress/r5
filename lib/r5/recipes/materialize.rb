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


create_file "#{@project_path}/config/webpack/custom.js" do <<-JS
  const webpack = require('webpack')
  
  module.exports = {
    resolve: {
      alias: {
        jquery: 'jquery/src/jquery',
      }
    },
  }
  
  // config/webpack/development.js
  const merge = require('webpack-merge')
  const environment = require('./environment')
  const customConfig = require('./custom')
  
  module.exports = merge(environment.toWebpackConfig(), customConfig)
JS
end

insert_into_file "#{@project_path}/app/javascript/packs/application.js",
                 after: "console.log('Hello World from Webpacker')" do <<-JS
                 
import jQuery from 'jquery'
window.jQuery = jQuery

let ready;
ready = function() {
  // $(".datepicker").datetimepicker({locale: 'cs', format: 'D. M. YYYY'});
};
// Fire javascript after turbolinks event
$(document).on('turbolinks:load', ready);
JS
end

insert_into_file "#{@project_path}/config/webpack/environment.js",
                 after: "const { environment } = require('@rails/webpacker')" do <<-JS

  const webpack = require('webpack')
  
  // Add an additional plugin of your choosing : ProvidePlugin
  environment.plugins.set(
    'Provide',
    new webpack.ProvidePlugin({
      $: 'jquery',
      jQuery: 'jquery',
      jquery: 'jquery',
    })
  )
JS
end
