namespace :server do
  STAGE = "STAGE_SERVER"
  PRODUCTION = "PROD_SERVER"
  PORT = "PORT_NUMBER"

  SERVER_DIR = '/home/www/PROJECT_DIR'

  desc 'Uploads to production server'
  task :upload_production => :environment do
    app_upload "-p#{PORT} USER_NAME@#{PRODUCTION}"
  end

  desc 'Uploads to stage server'
  task :upload => :environment do
    app_upload "-p#{PORT} USER_NAME@#{STAGE}"
  end

  def app_upload server_ssh
    puts "Really upload to \033[0;37m#{SERVER_DIR}\033[0;32m ?"
    STDIN.gets

    puts 'Pull from git'
    `git pull`

    puts 'Push to git'
    `git push`

    print 'Assets change? '
    puts change_assets = !!(`git diff --name-only HEAD^` =~ /assets/)

    system %Q(ssh -t #{server_ssh} "source .zshrc && deploy.sh #{SERVER_DIR} #{change_assets}")
  end
end
