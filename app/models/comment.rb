class Comment < ActiveRecord::Base

  validates(:title, {presence: true, uniqueness: {message: "must be unique per blog post!"}})

end
