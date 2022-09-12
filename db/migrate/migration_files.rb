# create_post.rb
class CreatePosts < ActiveRecord::Migration[7.0]
    def change
      create_table :posts do |t|
        t.string :title
        t.text :body
  
        t.timestamps
      end
    end
  end

  # create_comments.rb
  class CreateComments < ActiveRecord::Migration[7.0]
    def change
      create_table :comments do |t|
        t.text :body
        t.references :post, null: false, foreign_key: true
  
        t.timestamps
      end
    end
  end

# create_users.rb
class CreateUsers < ActiveRecord::Migration[7.0]
    def change
      create_table :users do |t|
        t.string :first_name
        t.string :last_name
        t.string :email
        t.string :password_digest
        t.boolean :is_admin, default: false
  
        t.timestamps
      end
    end
  end

# add_user_to_comments.rb
class AddUserToComments < ActiveRecord::Migration[7.0]
    def change
      add_reference :comments, :user, foreign_key: :true
    end
  end

# add_user_to_posts.rb
class AddUserToPosts < ActiveRecord::Migration[7.0]
    def change
      add_reference :posts, :user, foreign_key: true
    end
  end
  