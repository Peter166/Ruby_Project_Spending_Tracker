require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry' )
require_relative( '../models/budget.rb' )
require_relative( '../models/company.rb' )
require_relative( '../models/transaction.rb' )
require_relative( '../models/type.rb' )
also_reload( '../models/*' )


get '/transactions' do

  @transactions = Transaction.all
  @budgets = Budget.all

  @total = Transaction.total
  @total_budget = Budget.total

  @money_left = @total_budget - @total

  erb ( :"transactions/index" )
end


post '/transactions' do
  transaction = Transaction.new(params)
  transaction.save
  redirect to("/transactions")
end

post '/transactions/:id/update' do
  @transaction = Transaction.new(params)
  @transaction.update
  redirect("/transactions")
end

get '/transactions/new' do
  @types = Type.all
  @companies = Company.all
  erb(:"/transactions/new")
end

get '/transactions/:id/edit' do
  order_id = params[:id]
  @transaction = Transaction.find(order_id)
  @companies = Company.all
  @types = Type.all
  erb(:"/transactions/edit")
end

post '/transactions/budget'do
@budget = params[:budget]
end

post "/transactions/dissect" do


  @transactions = Transaction.time(params[:time1],  params[:time2])
  erb(:"/transactions/dissect")
end

get '/transactions/:id' do
  order_id = params[:id]
  @transaction = Transaction.find(order_id)
  erb(:"/transactions/show")
end



post '/transactions/by_companies' do

@transactions = Transaction.all_companies(params[:company_id])
erb(:"/transactions/by_companies")
end

post '/transactions/by_types' do
@transactions = Transaction.all_types(params[:type_id])
erb(:"/transactions/by_types")
end



post '/transactions/:id/delete' do
  Transaction.destroy(params[:id])
  redirect to("/transactions")
end
