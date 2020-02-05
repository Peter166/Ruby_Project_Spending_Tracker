require_relative( '../db/sql_runner' )
require ('time')


class Transaction
  attr_reader :id
  attr_accessor :company_id, :type_id, :amount, :time

  def initialize (options)
    @id = options['id'] if options['id']
    @company_id = options['company_id']
    @type_id = options['type_id']
    @amount = options['amount'].to_f
    @time = Time.now
  end


  def save()
    sql = "INSERT INTO transactions
    (company_id,type_id,amount, time)
    VALUES ($1, $2 ,$3, $4)
    RETURNING id"
    values = [@company_id, @type_id, @amount, @time]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end



  def self.delete_all()
    sql = "DELETE FROM transactions"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM transactions"
    results = SqlRunner.run(sql)
    return results.map {|hash| Transaction.new(hash)}
  end


  def company()
    sql="SELECT * FROM companies WHERE id = $1"
    values =[@company_id]
    results = SqlRunner.run(sql, values)
    return Company.new(results.first)
  end

  def type()
    sql="SELECT * FROM types WHERE id = $1"
    values =[@type_id]
    results = SqlRunner.run(sql, values)
    return Type.new(results.first)

  end


  def self.total()
    sql = "SELECT * FROM transactions"
    results = SqlRunner.run(sql)
    results = results.map {|hash| Transaction.new(hash)}
    total = 0
    for transaction in results
      total += transaction.amount.to_f
    end
    return total
  end

  def update()
    sql = "UPDATE transactions SET (company_id, type_id, amount, time) = ($1, $2, $3, $4)
    WHERE id = $5"
    values = [@company_id, @type_id, @amount, @time, @id]
    result = SqlRunner.run(sql, values)
  end


  def self.destroy(id)
    sql = "DELETE FROM transactions
    WHERE id = $1"
    values = [id]
    SqlRunner.run( sql, values )
  end


  def self.find( id )
    sql = "SELECT * FROM transactions WHERE id = $1"
    values = [id]
    transaction = SqlRunner.run( sql, values )
    result = Transaction.new( transaction.first )
    return result
  end

  def self.time(time1, time2)

    sql = "SELECT * FROM transactions"
    transactions = SqlRunner.run(sql)
    arr =[]
    for transaction in transactions

      transaction_time  = Time.parse(transaction["time"])
      time1_time  = Time.parse(time1)
      time2_time  = Time.parse(time2)


      if transaction_time >= time1_time && transaction_time <= time2_time
        arr.push(transaction)
      end
    end
    return arr.map { |transaction| Transaction.new(transaction) }
  end

  def self.all_companies(company_id)
    sql ="SELECT * FROM transactions WHERE company_id = $1"
    values =[company_id]
    transactions = SqlRunner.run(sql, values)
    return transactions.map { |transaction| Transaction.new(transaction) }
  end


  def self.all_types(type_id)
    sql ="SELECT * FROM transactions WHERE type_id = $1"
    values =[type_id]
    transactions = SqlRunner.run(sql, values)
    return transactions.map { |transaction| Transaction.new(transaction) }
  end
end
