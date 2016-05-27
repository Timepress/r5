
insert_into_file "#{@project_path}/config/application.rb",
                 after: "class Application < Rails::Application\n" do <<-EOF
      config.generators do |g|
            g.test_framework :rspec,
              :fixtures => true,
              :view_specs => false,
              :helper_specs => false,
              :routing_specs => false,
              :controller_specs => true,
              :request_specs => true,

              :assets => false
            g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      end
EOF
end
run 'rails g rspec:install'