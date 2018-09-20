require_relative( "./models/star")
require_relative( "./models/movie")
require_relative( "./models/casting")

require('pry-byebug')

Casting.delete_all()
Movie.delete_all()
Star.delete_all()

star1 = Star.new({ "first_name" => "Miss", "last_name" => "Piggy"})
star1.save()
star2 = Star.new({ "first_name" => "Kermit", "last_name" => "The Frog"})
star2.save()
star3 = Star.new({ "first_name" => "Fozzy", "last_name" => "Bear"})
star3.save()
star4 = Star.new({ "first_name" => "Julia", "last_name" => "Roberts"})
star4.save()

star3.first_name = "Fozzi"
star3.update()

movie1 = Movie.new({ "title" => "The Pelican Brief", "genre" => "Thriller", "budget" => 10})
movie1.save()
movie2 = Movie.new({ "title" => "Phantom of the Opera", "genre" => "Drama", "budget" => 11000})
movie2.save()
movie3 = Movie.new({ "title" => "Kermit's Swamp Years", "genre" => "Biopic", "budget" => 20000})
movie3.save()
movie4 = Movie.new({ "title" => "Muppet Treasure Island", "genre" => "Adventure", "budget" => 7772})
movie4.save()

casting1 = Casting.new({ "movie_id" => movie1.id, "star_id" => star4.id, "fee" => 7})
casting1.save()
casting2 = Casting.new({ "movie_id" => movie2.id, "star_id" => star1.id, "fee" => 9000})
casting2.save()
casting3 = Casting.new({ "movie_id" => movie3.id, "star_id" => star2.id, "fee" => 7000})
casting3.save()
casting4 = Casting.new({ "movie_id" => movie3.id, "star_id" => star1.id, "fee" => 9000})
casting4.save()
casting5 = Casting.new({ "movie_id" => movie3.id, "star_id" => star3.id, "fee" => 1500})
casting5.save()

binding.pry
nil
