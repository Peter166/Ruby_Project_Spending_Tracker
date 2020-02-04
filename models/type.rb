require_relative( '../db/sql_runner' )

class Type

  attr_reader :id
  attr_accessor :type


  def initialize (options)

    @id = options['id'].to_i if options['id']
    @type = options['type'].downcase
  end

  def save()
    sql = "INSERT INTO types
    (type)  VALUES  ($1)
    RETURNING id"
    values = [@type]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.delete_all()
    sql =" DELETE FROM types"
    SqlRunner.run(sql)
  end

  def self.all()
    sql =" SELECT * FROM types"
    results = SqlRunner.run(sql)
    return results.map { |hash| Type.new( hash ) }
  end


  def update()
      sql = "UPDATE types SET (type) = ($1)
      WHERE id = $2"
      values = [@type, @id]
      result = SqlRunner.run(sql, values)
    end

    def self.destroy(id)
    sql = "DELETE FROM types
    WHERE id = $1"
    values = [id]
    SqlRunner.run( sql, values )
  end
end
