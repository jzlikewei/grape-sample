require 'bundler'
Bundler.require(:default, ENV['RACK_ENV'] || :development)
# initialize log
require 'logger'
root_path = File.expand_path('../..', __FILE__)

Dir.mkdir(root_path + '/log') unless File.exist?(root_path + '/log')
class ::Logger; alias write <<; end
case ENV['RACK_ENV']
when 'production'
  logger = ::Logger.new(root_path + '/log/production.log')
  logger.level = ::Logger::INFO
when 'development'
  # logger = ::Logger.new(STDOUT)
  logger = ::Logger.new(root_path + '/log/development.log')
  logger.level = ::Logger::DEBUG
else
  logger = ::Logger.new('/dev/null')
end
Grape::API.class_exec do
  def self.paginate!
    # puts self
    params do
      optional :limit, type: Integer, default: 8, values: 1..100
      optional :count, type: Grape::API::Boolean, default: false
      optional :page, type: Integer, default: 1
    end
  end
end
module Pagination
  # extend ActiveSupport::Concern
  def paginate(params)
    # pagination code goes here
    if params[:count]
      count
    else
      limit(params[:limit]).offset(params[:limit] * (params[:page] - 1))
    end
  end
end
class Hash
  def permit(*args)
    select { |key, _| args.include?(key.to_s) || args.include?(key.to_sym) }
  end
end

ActiveRecord::Base.extend(Pagination)

Dir.glob(File.join(root_path, 'app', 'models', '*.rb')).each { |file| require file }
Dir.glob(File.join(root_path, 'app', 'api', '*.rb')).each { |file| require file }
# Dir.glob(File.join(root_path, 'app', 'monkey_patch', '*.rb')).each { |file| require file }

ActiveRecord::Base.logger = logger
OTR::ActiveRecord.configure_from_file! 'config/database.yml'
# ActiveRecord::Base.connection_pool.with_connection do
#   ActiveUUID::Patches.apply!
# end
