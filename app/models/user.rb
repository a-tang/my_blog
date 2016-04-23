class User < ActiveRecord::Base
    has_many :posts, dependent: :nullify
    has_many :comments, dependent: :nullify
    has_many :favourites, dependent: :destroy
    has_many :faved_

    has_secure_password
    validates :first_name, presence: true
    validates :last_name, presence: true

    VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    validates :email, uniqueness: true, presence: true, format: VALID_EMAIL_REGEX



    def full_name
      "#{first_name} #{last_name}"
    end

    def user_full_name
      user ? user.full_name : ""
    end

  end

  private

  def titleize_title
    self.title = title.titleize
  end
