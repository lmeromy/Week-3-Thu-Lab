require_relative("../db/sql_runner")


class Casting

attr_accessor :fee
attr_reader :id, :star_id, :movie_id

  def initialize(options)

    @id = options["id"].to_i if options["id"]
    @star_id = options["star_id"].to_i
    @movie_id = options["movie_id"].to_i
    @fee = options["fee"].to_i

  end

  def save()
    sql = "INSERT INTO castings (star_id, movie_id, fee) VALUES ($1, $2, $3)
    RETURNING id"
    values = [@star_id, @movie_id, @fee]
    result = SqlRunner.run(sql, values).first
    @id = result["id"].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM castings"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM castings"
    result = SqlRunner.run(sql)
    return result.map{|result_hash| Casting.new(result_hash)}

  end


end
