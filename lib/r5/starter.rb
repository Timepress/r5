require 'thor'
require_relative 'odin'
require_relative 'config'

class Starter < Thor
  include Thor::Actions
  include Odin

  def initialize(*args)
    super
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
    run "rails new #{@project_name} -T --skip-bundle"

    @project_path = "#{@dir}/#{@project_name}"
    @project_label = @project_name.capitalize.gsub('_', ' ')

    Dir.chdir @project_path

    # TODO read some config folder in home directory for user customized installations types
    unless options[:type]
      apply 'installations/default.rb'
    else
      apply "installations/#{options[:type]}.rb"
    end
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
    def source_paths
      root_path = File.dirname __FILE__
      [root_path + '/template', root_path]
    end

    def copy filename
      copy_file filename, "#{@project_path}/#{filename}"
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
  end

end
