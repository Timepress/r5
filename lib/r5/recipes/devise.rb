
# TODO add checking for existing devise in project
add_gem 'devise'

run 'bundle install'
run 'rails g devise:install'
run 'rails g devise User'

insert_into_file "#{@project_path}/app/controllers/application_controller.rb",
                 after: "class ApplicationController < ActionController::Base\n" do <<-RUBY
    protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :authenticate_user!

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :password, :remember_me) }
      devise_parameter_sanitizer.for(:account_update) { |u|
        u.permit(:password, :password_confirmation, :current_password)
      }
    end

    def only_for_user
      complain unless current_user
    end

    def only_for_admin
      complain unless current_user && current_user.admin?
    end

    def complain
      # TODO - 404 or just polite 'permissions denied'
      raise StandardError.new 'permissions denied'
    end
RUBY
end

insert_into_file "#{@project_path}/app/models/user.rb",
                 after: "class User < ApplicationRecord\n" do <<-RUBY
    def display_name
      [firstname, lastname].join(' ')
    end

RUBY

end

#TODO check for devise
user_migrate_filename = Dir.glob("#{@project_path}/db/migrate/*devise_create_users.rb").first
unless File.open(user_migrate_filename).read=~/string :login/
  gsub_file user_migrate_filename, 't.string :email,', "t.string :login,              null: false, default: ''\n      t.string :email,"
  gsub_file user_migrate_filename, ':encrypted_password, null: false, default: ""' do <<-RUBY
        :encrypted_password, null: false, default: ''
        t.string :firstname, null: false, default: ''
        t.string :lastname, null: false, default: ''
        t.boolean :admin, null: false, default: false
  RUBY
  end
end

# part for editing users and own password
copy 'app/controllers/users_controller.rb'
Dir.mkdir "#{@project_path}/app/views/users"
directory 'app/views/users', "#{@project_path}/app/views/users"

# different options can be used - this one is allowing admins to change passwords to other users
# - edit_user_registration_path can be used instead - then only user can change his/her own password

gsub_file "#{@project_path}/config/routes.rb", 'devise_for :users' do
<<EOF
  devise_for :users
  scope "/admin" do
    resources :users
  end

  get 'edit_password/:id' => 'users#edit_password'
  resource :user, only: [:edit] do
    collection do
      patch 'update_password'
    end
  end

  get 'edit_own_password' => 'users#edit_own_password'
EOF
end

gsub_file "#{@project_path}/config/routes.rb", "# root 'welcome#index'" do
  "root 'users#index'"
end


run 'rake app:bootstrap'
run 'rake db:migrate'
