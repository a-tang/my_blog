class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates(:body, {presence: true, uniqueness: {message: "must be unique per blog post!"}})

  def user_full_name
    user ? user.full_name : ""
  end
  
end
