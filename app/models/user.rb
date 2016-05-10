class User < ActiveRecord::Base
    has_many :posts, dependent: :nullify
    has_many :comments, dependent: :nullify
    has_many :favourites, dependent: :destroy
    # has_many :faved_

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

    def generate_password_reset_data
       generate_password_reset_token
       self.password_reset_requested_at = Time.now
       save
    end

  def password_reset_expired?
    password_reset_requested_at <= 60.minutes.ago
  end

  def generate_account_verification_data
    generate_account_verification_token
    self.account_verification_requested_at = Time.now
    save
  end

def generate_account_verification_token
  begin
    self.account_verification_token = SecureRandom.hex(32)
  end while User.exists?(account_verification_token: self.account_verification_token)
end

  def generate_password_reset_token
    begin
      self.password_reset_token = SecureRandom.hex(32)
    end while User.exists?(password_reset_token: self.password_reset_token)
  end

  def titleize_title
    self.title = title.titleize
  end
end
