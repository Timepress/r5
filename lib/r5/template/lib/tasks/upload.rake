namespace :server do
  SERVER = "USER_NAME@SERVER_NAME"
  PORT = "PORT_NUMBER"
  SSH = "-p#{PORT} #{SERVER}"
  SERVER_DIR = '/home/www/PROJECT_DIR'

  desc "Uploads to #{SERVER} server"
  task :upload => :environment do

    puts "Really upload to \033[0;37m#{SERVER_DIR}\033[0;32m ?"
    STDIN.gets

    puts 'Pull from git'
    `git pull`

    puts 'Push to git'
    `git push`

    print 'Assets change? '
    puts change_assets = !!(`git diff --name-only HEAD^` =~ /assets/)

    system %Q(ssh -t #{SSH} "source .zshrc && deploy.sh #{SERVER_DIR} #{change_assets}")
  end
end
