ENV('RACK_ENV') = 'test'

require('rspec')
require('pg')
require('player')
require('team')
require('pry')

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM players *;")
    DB.exec("DELETE FROM teams *;")
  end
end
