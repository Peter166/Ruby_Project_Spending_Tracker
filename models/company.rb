require_relative( '../db/sql_runner' )

class Company

  attr_reader :id
  attr_accessor :name, :status

  def initialize (options)
    @id = options['id'].to_i if options['id']
    @name = options['name'].upcase
    @status = options["status"]
  end

  def save()
    sql = "INSERT INTO companies
    (name, status)  VALUES  ($1, $2)
    RETURNING id"
    values = [@name, @status = true]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.all()
    sql ="SELECT * FROM companies"
    result = SqlRunner.run(sql)
    return result.map { |hash| Company.new( hash ) }
  end

  def self.delete_all()
    sql ="DELETE FROM companies"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE companies SET (name, status) = ($1, $2)
    WHERE id = $3"
    values = [@name, @status, @id]
    result = SqlRunner.run(sql, values)
  end

  def self.destroy(id)
    sql = "DELETE FROM companies
    WHERE id = $1"
    values = [id]
    SqlRunner.run( sql, values )
  end



  def status_active(x)

    sql = "SELECT * FROM companies WHERE id = $1"
    values = [id]
    company = SqlRunner.run( sql, values )
    result = Company.new( company.first )
    result.status = x
    result.update
    return result
  end




  def self.find( id )
    sql = "SELECT * FROM companies WHERE id = $1"
    values = [id]
    comp = SqlRunner.run( sql, values )
    result = Company.new( comp.first )
    return result
  end
end
