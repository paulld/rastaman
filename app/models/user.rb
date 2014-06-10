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

  def self.find_by_reset_code(password_reset_code)
    if user = User.find_by( :password_reset_code => password_reset_code )
    # TODO: diff between (:password_reset_code => password_reset_code) AND (password_reset_code: password_reset_code)  ??
      if user.password_reset_code_expires_at > Time.now
        user.password_reset_code_expires_at = Time.now + TIME_UNTIL_EXPIRE
        user.save
        user
      end
    end
  end

  def update_password(password, password_confirmation)
    self.protected_update_password(password, password_confirmation)
  end

  protected
  
  def protected_update_password(password, password_confirmation)
    self.password = password
    self.password_confirmation = password_confirmation
    self.password_reset_code = ""
    self.password_reset_code_expires_at = ""
    self.save
    self
  end

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