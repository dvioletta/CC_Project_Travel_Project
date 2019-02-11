require('sinatra')
require('sinatra/contrib/all')
require_relative('models/city')
require_relative('models/country')
require_relative('models/trip')
also_reload('./models/*')


get '/visits' do
  @cities = City.all
  erb(:index)
end
