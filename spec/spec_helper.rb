require 'active_record'
require 'rspec'
require 'shoulda-matchers'
require 'task'
require 'list'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["test"])

RSpec.configure do |config|
  config.after(:all) do
    Task.all.each {|task| task.destroy}
    List.all.each {|list| list.destroy}
  end
end