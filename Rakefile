#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.
$: << File.expand_path(File.dirname(__FILE__))
require 'bundler/setup'

load "tasks/otr-activerecord.rake"

namespace :db do
  task :environment do
    require 'config/environment'
  end
  task :dump do
    require 'config/environment'
    require 'service'
    require_relative './tools/seed_dump'
    include SeedDump
    dump
  end
end
task :environment do
  # root_path = File.expand_path('.', __FILE__)
  # Dir.glob(File.join(root_path, 'app', 'models', '*.rb')).each { |file| require file }
  # Dir.glob(File.join(root_path, 'app', 'mappers', '*.rb')).each { |file| require file }
  # Dir.glob(File.join(root_path, 'app', 'api', '**', '*.rb')).each { |file| require file } $: << File.expand_path(File.dirname(__FILE__))
  require 'config/environment'
  require 'service'
  #require File.expand_path('app', File.dirname(__FILE__))
end
namespace :grape do
  desc "Condensed API Routes"
  task :routes => :environment do
    mapped_prefix ='' #'/whatevs' # where mounted in routes.rb
    format = "%40s  %3s %7s %40s %12s:  %s"
    Service::App::API::FaceCloud.routes.each do |grape_route|
      info = grape_route.instance_variable_get :@options
      puts format % [
          info[:description] ? info[:description][0..45] : '',
          info[:version],
          info[:method],
          mapped_prefix + info[:path],
          '# params: ' + info[:params].length.to_s,
          info[:params].first.inspect
      ]
      if info[:params].length > 1
        info[:params].each_with_index do |param_info, index|
          next if index == 0
          puts format % ['','','','','',param_info.inspect]
        end
      end
    end
  end
end


#
# desc "API Routes"
# task :routes do
#   App::API.routes.each do |api|
#     method = api.route_method.ljust(10)
#     path = api.route_path
#     puts "     #{method} #{path}"
#   end
# end
