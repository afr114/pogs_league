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
  @teams = Team.all()
  erb(:league_manager)
end

post('/new_team') do
  name = params.fetch("name")
  win = params.fetch("wins").to_i()
  loss = params.fetch("losses").to_i()
  team = Team.new({:name => name, :win => win, :loss => loss})
  team.save()
  @teams = Team.all()
  redirect("/league_manager")
end

delete('/teams/:id') do
  @team = Team.find(params.fetch("id").to_i())
  @team.delete()
  @teams = Team.all()
  redirect("/league_manager")
end

get('/teams/:id') do
  @team = Team.find(params.fetch("id").to_i())
  erb(:team)
end

patch('/teams/:id') do
  @team = Team.find(params.fetch("id").to_i())
  name = params.fetch("name")
  win = params.fetch("wins")
  loss = params.fetch("losses").to_i()
  @team.update({:name => name, :win => win, :loss => loss})
  redirect("/league_manager")
end
