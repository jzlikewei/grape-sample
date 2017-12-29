#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.
$LOAD_PATH << __dir__
require 'bundler/setup'

load 'tasks/otr-activerecord.rake'

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
  # require File.expand_path('app', File.dirname(__FILE__))
end

namespace :grape do
  desc 'Condensed API Routes'
  task routes: :environment do
    mapped_prefix = '' # '/whatevs' # where mounted in routes.rb
    format = '%40s  %2s %7s %50s %12s:  %s'
    API::GrapeApi.routes.each do |grape_route|
      path = grape_route.instance_variable_get(:@pattern).instance_variable_get(:@origin)
      info = grape_route.instance_variable_get :@options
      path = path.gsub(':version', info[:version]) unless info[:version].nil?
      # puts format(format, (info[:description] ? info[:description][0..45] : '').ljust(40), info[:version], info[:method].ljust(7), (mapped_prefix.to_s + path.to_s).ljust(50), '# params: ' + info[:params].length.to_s, info[:params].first.inspect)

      desc = info[:description] ? info[:description][0..45] : ''
      puts "### API-" + desc
      puts "  version: #{info[:version]}"
      puts "  #{info[:method]} #{(mapped_prefix.to_s + path.to_s).ljust(50)}"
      puts ""
      puts "#### 参数："
      puts "| 参数名称 | 参数类型 | 描述 | 是否必选 | 默认值 | 范围 |"
      puts "| - | - | - | :-: | :-: | :-: |"
      if info[:params].length == 0
        puts '| | | | | | |'
      else
        info[:params].each do |name, info|
          puts "| #{name} | #{info[:type]} | #{info[:desc]} | #{info[:required] ? '是' : '否'} | #{info[:default]} | #{info[:values]} |"
        end
      end
      puts ""

      next unless info[:params].length > 1
      info[:params].each_with_index do |param_info, index|
        next if index == 0
        # puts format(format, '', '', '', '', '', param_info.inspect)
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
