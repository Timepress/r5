add_gem 'foreman'

copy 'config/webpack.config.js'
Dir.mkdir "#{@project_path}/app/assets/webpack"
directory 'app/assets/webpack', "#{@project_path}/app/assets/webpack"
copy 'Procfile'

gsub_file "#{@project_path}/app/views/layouts/application.html.erb", /<div class="container container-large content">(.*)?<\/div>/m, <<EOF
  <div id="vue-instance">
      <app>
        <% flash.each do |name, msg| %>
          <%= content_tag :div, :class => "alert alert-\#{ name == :error ? "danger" : "success" } alert-dismissable" do %>
            <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
            <%= msg %>
          <% end %>
        <% end %>
    
        <%= yield %>
      </app>
    </div>
EOF

append_to_file "#{@project_path}/.gitignore" do
  <<EOF
app/assets/javascripts/webpack\.bundle\.js
EOF
end

package_json = "#{@project_path}/package.json"
gsub_file package_json, '"private": true,',   <<EOF
"private": true,
  "scripts": {
    "build": "webpack --config config/webpack.config.js --mode development",
    "build:release": "webpack --config config/webpack.config.js --mode production",
    "start": "foreman start"
  },
EOF

run 'npm install vue vuex vue-turbolinks'
run 'npm install --save-dev babel-core babel-loader babel-preset-env css-loader node-sass sass-loader sockjs-client uglifyjs-webpack-plugin vue-loader vue-style-loader vue-template-compiler webpack webpack-cli webpack-dev-server webpack-preprocessor-loader webpack-watch-files-plugin write-assets-webpack-plugin write-file-webpack-plugin'
run 'npm install'