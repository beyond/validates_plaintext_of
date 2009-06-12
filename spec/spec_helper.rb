# ---- requirements
$LOAD_PATH.unshift File.expand_path("../lib", File.dirname(__FILE__))

RAILS_ENV = ENV['RAILS_ENV'] = 'test'

require 'rubygems'
require 'spec'
require 'active_record'
require 'validates_plaintext_of'
