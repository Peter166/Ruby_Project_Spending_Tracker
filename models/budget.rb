require_relative( '../db/sql_runner' )

class Budget

  attr_reader :id
  attr_accessor :budget


  def initialize (options)

    @id = options['id'].to_i if options['id']
    @budget = options['budget'].to_i
  end

  def save()
    sql = "INSERT INTO budgets
    (budget)  VALUES  ($1)
    RETURNING id"
    values = [@budget]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end
  def self.all()
    sql ="SELECT * FROM budgets"
    result = SqlRunner.run(sql)
    return result.map { |hash| Budget.new( hash ) }
  end

  def self.delete_all()
    sql =" DELETE FROM budgets"
    SqlRunner.run(sql)
  end

  def self.all()
    sql =" SELECT * FROM budgets"
    results = SqlRunner.run(sql)
    return results.map { |hash| Budget.new( hash ) }
  end


  def update()
      sql = "UPDATE budgets SET (budget) = ($1)
      WHERE id = $2"
      values = [@budgets, @id]
      result = SqlRunner.run(sql, values)
    end

    def self.destroy(id)
    sql = "DELETE FROM budgets
    WHERE id = $1"
    values = [id]
    SqlRunner.run( sql, values )
  end

  def self.total()
    sql = "SELECT * FROM budgets"
    results = SqlRunner.run(sql)
    results = results.map {|hash| Budget.new(hash)}
    total = 0
    for budget in results
      total += budget.budget
    end
    return total
  end
end
