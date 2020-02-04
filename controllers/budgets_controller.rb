require( 'sinatra' )
require( 'sinatra/contrib/all' )
require('pry')
require_relative( '../models/company.rb' )
require_relative( '../models/transaction.rb' )
require_relative( '../models/type.rb' )
require_relative( '../models/budget.rb' )
also_reload( '../models/*' )

get '/budgets' do
  @budgets = Budget.all
  @total_budget = Budget.total
  erb ( :"budgets/add" )
end

get '/budgets/add' do
  binding.pry
  @budgets = Budget.all
  @total_budget = Budget.total
  redirect ("/transactions")
end

get '/budgets/new' do
  @budgets = Budget.all
  erb(:"budgets/new")
end


post '/budgets' do
  budgets = Budget.new(params)
  budgets.save()
  erb( :"budgets/index")
end
