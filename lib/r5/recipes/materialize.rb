add_gem 'materialize-sass'
add_gem 'material_icons'

run 'bundle install'

system "yarn add jquery moment snackbarjs"

insert_into_file "#{@project_path}/app/assets/stylesheets/application.css",
before: "\n *= require_tree ." do <<-TXT
  
  *= require materialize
  *= require material_icons
  *= require snackbarjs
TXT
end

insert_into_file "#{@project_path}/app/assets/javascripts/application.js",
before: "\n//= require_tree ." do <<-TXT
  
  //= require materialize-sprockets
  //= snackbarjs
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
