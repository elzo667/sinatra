require 'bundler'
Bundler.require
require 'gossip'
class ApplicationController < Sinatra::Base
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end
  get '/gossips/new/' do
    erb :new_gossip
  end
  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

  get '/gossips/:id/' do
    "Voici le numéro du potin que tu veux ! #{params['id']}!"
    gossip = Gossip.find(params["id"])
    id = params['id'].to_i
    erb :show, locals: {gossip: gossip, id: id}
  end



  get '/gossips/:id/edit/' do
    gossip = Gossip.all
    id = params['id'].to_i
    erb :edit, locals: {gossip: gossip, id: id}
  end

  post '/gossips/:id/edit/' do
    id = params['id'].to_i
    Gossip.update(id, params["gossip_author"], params["gossip_content"])
    redirect '/'
  end


  run! if app_file == $0
end 