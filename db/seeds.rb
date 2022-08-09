# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Post.destroy_all
Comment.destroy_all

10.times do
    created_at = Faker::Date.backward(days:365 * 5)
 
    p = Post.create( 
        body: Faker::Lorem.paragraph,
        title: Faker::Movie.quote,
        created_at: created_at,
        updated_at: created_at
    )
    if (p.valid?) 
        rand(1..5).times do
            Comment.create(
                body: Faker::Lorem.paragraph,
                created_at: created_at,
                updated_at: created_at,
                post: p
            )
        end
    end
end

posts = Post.all
comments = Comment.all

puts Cowsay.say("Generated #{posts.count} posts", :tux)
puts Cowsay.say("Generated #{comments.count} comments", :cow)

 