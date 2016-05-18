class User < ActiveRecord::Base
  has_secure_password
  has_many :posts, dependent: :nullify
  has_many :comments, dependent: :nullify
  has_many :favourites, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true, unless: :with_oauth?
  validates :email, presence: true, uniqueness: true, unless: :with_oauth?

  serialize :twitter_raw_data, Hash

  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :email, uniqueness: true, presence: true, format: VALID_EMAIL_REGEX, unless: :with_oauth?

  def with_oauth?
    provider.present? && uid.present?
  end

  def self.find_or_create_with_twitter(omniauth_data)
    user = User.where(provider: "twitter", uid: omniauth_data["uid"]).first
    unless user
      full_name = omniauth_data["info"]["name"]
      user = User.create!(first_name:      extract_first_name(full_name),
                         last_name:        extract_last_name(full_name),
                         provider:         "twitter",
                         uid:              omniauth_data["uid"],
                         password:         SecureRandom.hex(16),
                         twitter_token:    omniauth_data["credentials"]["token"],
                         twitter_secret:   omniauth_data["credentials"]["secret"],
                         twitter_raw_data: omniauth_data)
    end
    user
  end

  def from_omniauth?
    uid.present? && provider.present?
  end

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

  private

  def self.extract_first_name(full_name)
    if full_name.rindex(" ")
      full_name[0..full_name.rindex(" ")-1]
    else
      full_name
    end
  end

  def self.extract_last_name(full_name)
    if full_name.rindex(" ")
      full_name.split.last
    else
      ""
    end
  end
end
