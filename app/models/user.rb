require 'bcrypt'

class User
  include Mongoid::Document

  TIME_UNTIL_EXPIRE = 2.hours

  before_save :encrypt_password, :downcase_email

  attr_accessor :password, :password_confirmation

  field :email
  field :salt
  field :fish
  field :password_reset_code
  field :password_reset_code_expires_at, type: Time

  validates :email, presence: true, format: { with: EMAIL_REGEX }
  validates :password, confirmation: true

  def authenticate(password)
    self.fish == BCrypt::Engine.hash_secret(password, self.salt)
  end

  def self.authenticate(email, password)
    user = User.find_by( email: email )
    user if user && user.authenticate(password)
  end

  def generate_password_reset_code
    self.set_password_reset_code_and_expiration
  end

  protected

  def encrypt_password
    self.salt = BCrypt::Engine.generate_salt
    self.fish = BCrypt::Engine.hash_secret(password, self.salt)
  end

  def downcase_email
    self.email.downcase!
  end

  def set_password_reset_code_and_expiration
    self.password_reset_code = SecureRandom.urlsafe_base64
    self.password_reset_code_expires_at = Time.now + TIME_UNTIL_EXPIRE
    self.save
  end

end