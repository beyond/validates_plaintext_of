require 'rubygems'
require 'active_support'
require 'active_support/test_case'
require 'active_record'
require 'test/unit'

$:.unshift File.dirname(__FILE__) + '/../lib'
require File.dirname(__FILE__) + '/../init'

ActiveRecord::Base.establish_connection({
  :adapter => "sqlite3",
  :database => ":memory:",
})
 
ActiveRecord::Schema.define(:version => 1) do
  create_table :entry, :force=>true do |t|
    t.string :title
    t.string :comment
    t.timestamps
  end
end
