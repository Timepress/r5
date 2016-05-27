require 'yaml'

class Config

  def self.settings
    if File.exists? "#{ENV['HOME']}/.r5.yml"
      YAML::load_file("#{ENV['HOME']}/.r5.yml")
    else
      'You need to create ~/.r5.yml file, check github for example.'
    end
  end
end