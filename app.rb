require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('controllers/companies_controller')
require_relative('controllers/transactions_controller')
require_relative('controllers/types_controller')
require_relative('controllers/budgets_controller')

get '/' do
  @total_budget = Budget.total
  erb( :index )
end
