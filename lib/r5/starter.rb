require 'thor'
require_relative 'odin'
require_relative 'config'

class Starter < Thor
  include Thor::Actions
  include Odin

  def initialize(*args)
    super
    unless File.exists? "#{Dir.home}/.r5.yml"
      say "Need to create config file - answer following question", :green
      create_config_file
    end

    if (system "rails -v").nil? or (%x[rails -v] =~ /Rails 5.1.*/).nil?
      say "You didn't install Rails or have version lower than 5.1 Please install proper version.", :red
      abort
    end

    if (system "yarn --version").nil?
      say "You need to install yarn on your system to manage javascript assets", :red
      abort
    end

    if (system "webpack").nil?
      say "You need to install webpack", :red
      abort
    end

    unless Config.check_settings.empty?
      say Config.check_settings, :green
      say 'Check structure of your config file - it seems you are missing required options mentioned above', :red
      abort
    end

    if ARGV[0] =~ /new/
      @dir = `pwd`.gsub("\n", '')
    elsif ARGV[0] =~ /add/
      if yes? 'Are you in right folder of your app?'
        @project_path = `pwd`.gsub("\n", '')
        @project_name = @project_path.split('/').last
        @project_label = @project_name.capitalize.gsub('_', ' ')
      else
        say 'Get to proper directory', :red
        abort
      end
    end
  end

  long_desc <<-LONGDESC
    Available types of installations are:
    #{Dir.entries("#{File.dirname(File.expand_path(__FILE__))}/installations/")
          .reject {|f| File.directory? f}
          .join(', ')}
  LONGDESC
  desc 'new PROJECT_NAME --type', 'install rails application, you can specify type on installation with type argument'
  method_options type: :string
  def new project_name
    @project_name = project_name
    run "rails new #{@project_name} -T --skip-bundle --webpack"
    #run 'rake webpacker:install'

    @project_path = "#{@dir}/#{@project_name}"
    @project_label = @project_name.capitalize.gsub('_', ' ')

    Dir.chdir @project_path

    # TODO read some config folder in home directory for user customized installations types
    unless options[:type]
      apply 'installations/default.rb'
    else
      apply "installations/#{options[:type]}.rb"
    end

    run 'gem install foreman'
    copy 'Procfile'
    say 'Start your application with foreman start', :green
  end

  desc 'add_timepress_specifics', 'add datepicker and other timepress specific things'
  def add_timepress_specifics
    apply 'recipes/timepress_specifics.rb'
  end

  desc 'add_rack_mini_profiler', 'add profiling tool to help you keep an eye on performance'
  def add_rack_mini_profiler
    apply 'recipes/add_rack_mini_profiler.rb'
  end

  desc 'add_wicked_pdf', 'add pdf generation to project'
  def add_wicked_pdf
    apply 'recipes/wicked_pdf.rb'
  end

  desc 'add_xlsx_support', 'add gems for working with excel files'
  def add_xlsx_support
    apply 'recipes/xlsx_support.rb'
  end

  desc 'add_lazy_charts', 'add gems for charts creating'
  def add_lazy_charts
    apply 'recipes/lazy_high_charts.rb'
  end

  desc 'add_datatables', 'add gems for datatables'
  def add_datatables
    say 'Not ready yet!', :red
    #gem 'jquery-datatables-rails', '~> 2.2.3'
  end

  desc 'add_exception_notification', 'add exception notification to project'
  def add_exception_notification
    apply 'recipes/exception_notification.rb'
  end

  desc 'add_skylight', 'add gems for skylight reporting'
  def add_skylight
    say 'Not ready yet!', :red
    #gem 'skylight'
  end

  desc 'add_in_place_editing_support', 'add gems for in place editing'
  def add_best_in_place
    say 'Not ready yet!', :red
    #gem 'best_in_place'
  end

  desc 'add_mail_support', 'add gems for working with mail'
  def add_mail_gem
    say 'Not ready yet!', :red
    #gem 'mail'
  end

  # local helpers
  no_commands do
    require 'yaml'
    def create_config_file
      settings = Hash.new {|h,k| h[k] = Hash.new(&h.default_proc) }
      settings['mysql']['user'] = ask("Insert name of mysql user:")
      settings['mysql']['password'] = ask("Insert password for mysql user:")
      settings['mysql']['host'] = ask("Host of mysql user:", default: 'localhost')
      settings['admin']['login'] = ask("Login of default admin user:", default: 'admin')
      settings['admin']['password'] = ask("Password of default password:", default: 'password')
      settings['admin']['email'] = ask("E-mail of default user:", default: 'admin@example.com')
      settings['admin']['lastname'] = ask("Lastname of default user:", default: 'administrator')
      settings['notifier']['email'] = ask("Email for exception notification:", default: 'code@example.com')
      settings['server']['name_prod'] = ask("Production server adddress:")
      settings['server']['name_stage'] = ask("Stage server address:")
      settings['server']['port'] = ask("SSH port for both:")
      settings['server']['user'] = ask("Name of user on servers:")

      File.open("#{Dir.home}/.r5.yml", 'w') do |file|
        file.write(settings.to_yaml)
      end
    end

    def source_paths
      root_path = File.dirname __FILE__
      [root_path + '/template', root_path]
    end

    def copy filename, destination_name=nil
      new_name = destination_name ? destination_name : filename
      copy_file filename, "#{@project_path}/#{new_name}"
    end

    def my_directory path
      # rewriting thor directory method
      directory path, "#{@project_path}/#{path}"
    end

    def remove filename
      remove_file "#{@project_path}/#{filename}"
    end

    def add_gem name
      append_to_file "#{@project_path}/Gemfile" do
        "\ngem '#{name}'"
      end
    end

    def check_gem_existence name
      File.read("#{@project_path}/Gemfile") =~ /#{name}/
    end
  end

end
