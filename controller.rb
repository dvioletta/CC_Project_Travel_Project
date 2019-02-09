require('sinatra')
require('sinatra/contrib/all')
require_relative('models/city')
require_relative('models/country')
require_relative('models/trip')
also_reload('./models/*')


get '/' do
  
end
