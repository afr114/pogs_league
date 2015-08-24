require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
require('./lib/player')
require('./lib/team')
also_reload('lib/**/*.rb')
require('pg')

get('/') do
  @teams = Team.all()
  erb(:index)
end

get('/league_manager') do
  erb(:league_manager)
end
