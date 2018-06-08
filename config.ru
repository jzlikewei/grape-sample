# This file is used by Rack-based servers to start the application.

$: << File.expand_path(File.dirname(__FILE__))
require 'config/environment'
require 'service'
use OTR::ActiveRecord::ConnectionManagement
file = File.new("log/#{ENV['RACK_ENV']}.log", 'a+')
file.sync = true
use Rack::CommonLogger, file
require 'rack/contrib'

use Rack::TryStatic, urls: ['/', 'assets'], root: 'public', index: 'index.html', try: ['.html', 'index.html', '/index.html']

run Service::App
