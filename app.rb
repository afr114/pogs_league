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

get('/team_captain') do
  @teams = Team.all()
  erb(:team_captain)
end

get('/team_captain/:id') do
  @players = Player.all()
  @team = Team.find(params.fetch("id").to_i())
  erb(:team_captain_team)
end

post('/new_player') do
  team_id = params.fetch("team_id")
  name = params.fetch("name")
  team_captain = params.fetch("team_captain")
  if team_captain == "yes"
    team_captain = true
  else
    team_captain = false
  end
  new_player = Player.new(:team_id => team_id, :name => name, :team_captain => team_captain)
  new_player.save()
  @team = Team.find(params.fetch("team_id").to_i())
  redirect("team_captain/#{@team.id()}")
end

delete('/team_captain/player/:id') do
  @player = Player.find(params.fetch("id").to_i())
  @player.delete()
  @players = Player.all()
  team_id = params.fetch('team_id')
  redirect("team_captain/#{team_id}")
end
