class Category < ActiveRecord::Base
  validates(:title, {presence: true, uniqueness: {message: "must be unique!"}})
end
