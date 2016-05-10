require 'bundler'
Bundler.require(:default, ENV['RACK_ENV'] || :development)
# initialize log
require 'logger'
root_path = File.expand_path('../..', __FILE__)

Dir.mkdir(root_path+'/log') unless File.exist?(root_path+'/log')
class ::Logger; alias_method :write, :<<; end
case ENV["RACK_ENV"]
  when "production"
    logger = ::Logger.new(root_path+"/log/production.log")
    logger.level = ::Logger::INFO
  when "development"
    # logger = ::Logger.new(STDOUT)
    logger = ::Logger.new(root_path+"/log/development.log")
    logger.level = ::Logger::DEBUG
  else
    logger = ::Logger.new("/dev/null")
end


Dir.glob(File.join(root_path, 'app', 'models', '*.rb')).each { |file| require file }
Dir.glob(File.join(root_path, 'app', 'api', '*.rb')).each { |file| require file }
# Dir.glob(File.join(root_path, 'app', 'monkey_patch', '*.rb')).each { |file| require file }

ActiveRecord::Base.logger = logger
Grape::ActiveRecord.configure_from_file!(File.join(root_path, 'config', 'database.yml'))
ActiveRecord::Base.connection_pool.with_connection do
  ActiveUUID::Patches.apply!
end


