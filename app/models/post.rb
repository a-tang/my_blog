class Post < ActiveRecord::Base
  has_many :comments, dependent: :nullify
  belongs_to :category
  belongs_to :user

  validates(:title, {presence: true, uniqueness: {message: "must be unique!"}})

  def self.search(search)
    where("title ILIKE ? OR body ILIKE ?", "%#{search}%", "%#{search}%")
  end

  def user_full_name
    user ? user.full_name : ""
  end

end
