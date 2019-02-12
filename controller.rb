require('sinatra')
require('sinatra/contrib/all')
require_relative('models/city')
require_relative('models/country')
require_relative('models/trip')
also_reload('./models/*')
require('pry')


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

  post '/visit' do #posts to two tables at once
  city = City.new(params)
  city.save
  options = {'country_id'=>params['country_id'], 'city_id'=>city.id, 'visited'=>'not visited'}
  trip = Trip.new(options)
  trip.save
  redirect to '/visits/list'
  end

  post '/visit/:id' do
    @trip = Trip.new(params)
    @trip.update
      redirect to 'visits/status'
  end

  get '/visit/:id/edit' do
    @city = City.find(params['id'])
    @countries = Country.all
    @trips = Trip.all
    @trip = Trip.find_by_city_id(@city.id)
    erb(:edit)
  end

  get '/visit/:id' do
    @city = City.find(params['id'])
    erb(:show)
  end

  post '/visit/:id/delete' do
    trip = Trip.find_by_city_id(params['id'])
    trip.delete()
    erb(:delete)
  end
