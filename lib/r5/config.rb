require 'yaml'

class Config

  REQUIRED_STRUCTURE = {'mysql' => {'user' => 'name',
                                    'password' => 'password',
                                    'host' => 'localhost'},
                        'admin' => {'login' => 'admin',
                                    'password' => 'password',
                                    'email' => 'admin@example.com',
                                    'lastname' => 'administrator'},
                        'notifier' => {'email' => 'code@example.com'},
                        'server' => {'name_prod' => 'production server',
                                     'name_stage' => 'stage server',
                                     'port' => 'ssh port',
                                     'user' => 'user name'}
  }

  def self.settings
    if File.exists? "#{ENV['HOME']}/.r5.yml"
      YAML::load_file("#{ENV['HOME']}/.r5.yml")
    else
      'You need to create ~/.r5.yml file, check github for example.'
    end
  end


  # TODO Space for improving structure check - now it is very simple and won't work properly for duplicated keys in deeper structure
  def self.check_settings
    all_keys(REQUIRED_STRUCTURE) - all_keys(settings)
  end

  def self.all_keys(hash)
    hash.flat_map { |k, v| [k] + (v.is_a?(Hash) ? all_keys(v) : []) }
  end
end