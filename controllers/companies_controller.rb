require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/company.rb' )
also_reload( '../models/*' )

get '/companies' do
  @companies = Company.all()
  erb ( :"companies/index" )
end


get '/companies/new' do
  @companies = Company.all
  erb(:"companies/new")
end

post '/companies/:id' do
  order_id = params[:id]
  @companies = Company.find(order_id)
  @companies.status = params[:status]
  @companies.update
  redirect to( "/companies")
end


post '/companies' do
  company = Company.new(params)
  company.save()
  redirect to("/companies")
end
