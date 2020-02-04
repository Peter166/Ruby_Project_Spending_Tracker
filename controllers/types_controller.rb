require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/type.rb' )
also_reload( '../models/*' )

get '/types' do
  @types = Type.all()
  erb ( :"types/index" )
end


get '/types/new' do
  @types = Type.all
  erb(:"types/new")
end


post '/types' do
  types = Type.new(params)
  types.save()
  redirect to("/types")
end
