namespace :app do
  desc 'Bootstrap the application -- create admin/admin user, migrate database, etc'
  task :bootstrap => :environment do

    `rake db:migrate`
    puts '* Migrated database'

    u = User.new :login     => "ADMIN_LOGIN",
                 :password  => "ADMIN_PASSWORD",
                 :password_confirmation => "ADMIN_PASSWORD",
                 :email     => "ADMIN_EMAIL",
                 :lastname => "ADMIN_LASTNAME"
    u.admin = true
    u.save
    puts '* Created default  *** INSECURE *** account.'
  end

    task :seed do
    end
end
