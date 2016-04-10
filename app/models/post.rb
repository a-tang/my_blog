class Post < ActiveRecord::Base

validates(:title, {presence: true, uniqueness: {message: "must be unique!"}})

  def self.search(search)
    where("title ILIKE ? OR body ILIKE ?", "%#{search}%", "%#{search}%")
  end
end
