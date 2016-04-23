class Post < ActiveRecord::Base
  has_many :comments, dependent: :nullify
  belongs_to :category
  belongs_to :user
  has_many :favourites, dependent: :destroy
  has_many :users, through: :favourites

  validates(:title, {presence: true, uniqueness: {message: "must be unique!"}})

  def self.search(search)
    where("title ILIKE ? OR body ILIKE ?", "%#{search}%", "%#{search}%")
  end

  def user_full_name
    user ? user.full_name : ""
  end

  def favourite_for(user)
    favourites.find_by_user_id user if user
  end

end
