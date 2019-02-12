require('sinatra')
require('sinatra/contrib/all')
require_relative('models/city')
require_relative('models/country')
require_relative('models/trip')
also_reload('./models/*')


get '/visits/list' do
  @cities = City.all
  erb(:index)
end

  get '/visits/status' do
  @trips = Trip.all
  erb(:Sindex)
  end

  get '/visit/new' do
    @countries = Country.all
    erb(:new)
  end

  post '/visit' do
  City.new(params).save
  redirect to '/visits/list'
  end

  post '/visit/:id' do
    @trip = Trip.new(params).update
      redirect to 'visits/status'
  end

  get '/visit/:id/edit' do
    @city = City.find(params['id'])
    @countries = Country.all
    @trips = Trip.all
    erb(:edit)
  end

  get '/visit/:id' do
    @city = City.find(params['id'])
    erb(:show)
  end
