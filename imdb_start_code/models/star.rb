require_relative("../db/sql_runner")

class Star

attr_reader :id
attr_accessor :first_name, :last_name

  def initialize(options)

    @id = options["id"].to_i if options["id"]
    @first_name = options["first_name"]
    @last_name = options["last_name"]
  end

  def save()
    sql = "INSERT INTO stars (first_name, last_name) VALUES ($1, $2)
    RETURNING id"
    values = [@first_name, @last_name]
    result = SqlRunner.run(sql, values).first
    @id = result["id"].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM stars"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM stars"
    result = SqlRunner.run(sql)
    return result.map{|result_hash| Star.new(result_hash)}

  end

  def movies()
    sql = "SELECT movies.* FROM movies INNER JOIN castings ON
    castings.movie_id = movies.id WHERE star_id = $1"
    values = [@id]
    movies = SqlRunner.run(sql, values)
    return movies.map {|movie_data| Movie.new(movie_data)}
  end

  def update()
    sql = "UPDATE stars SET (first_name, last_name) = ($1, $2) WHERE id = $3"
    values = [@first_name, @last_name, @id]
    SqlRunner.run(sql, values)
  end




end
