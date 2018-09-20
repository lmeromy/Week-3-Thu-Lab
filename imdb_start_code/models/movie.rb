require_relative("../db/sql_runner")

class Movie

  attr_reader :id, :title, :genre, :budget

  def initialize(options)

      @id = options["id"].to_i if options["id"]
      @title = options["title"]
      @genre = options["genre"]
      @budget = options["budget"].to_i

  end

  def save()
    sql = "INSERT INTO movies (title, genre, budget) VALUES ($1, $2, $3)
    RETURNING id"
    values = [@title, @genre, @budget]
    result = SqlRunner.run(sql, values).first
    @id = result["id"].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM movies"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM movies"
    result = SqlRunner.run(sql)
    return result.map{|result_hash| Movie.new(result_hash)}

  end


  #display all the stars in a movie
  def stars()
    sql = "SELECT stars.* FROM stars INNER JOIN
    castings ON castings.star_id = stars.id WHERE movie_id = $1"
    values = [@id]
    stars = SqlRunner.run(sql, values)
    return stars.map {|star_data| Star.new(star_data)}
  end


  def pay_fees()
    #going get casting objects, join to stars to pull in fees and then sum the star fees
    # subtract the above from the movie object budget. Return the balance.
    sql = "SELECT castings.star_id, castings.fee FROM castings
    INNER JOIN stars ON stars.id = castings.star_id
    WHERE id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    # calculation = results.map {|results_hash|results_hash.fee}
  end

end
