# require 'bcrypt'    # INFO: not necessary anymore?

# TODO: Profile page + edit user incl. change password action

class User
  include Mongoid::Document

  TIME_UNTIL_EXPIRE = 24.hours

  before_save :encrypt_password if :password
  before_save :downcase_email

  attr_accessor :password, :password_confirmation

  field :email
  field :salt
  field :fish
  field :password_reset_code
  field :password_reset_expires_at, type: Time
  field :first_name
  field :last_name
  field :user_name

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
    self.password_reset_code = SecureRandom.urlsafe_base64
    self.password_reset_expires_at = Time.now + TIME_UNTIL_EXPIRE
    self.save
  end

  def self.find_by_reset_code(password_reset_code)
    User.where( :password_reset_expires_at.lt => Time.now ).each do |user|
      user.clear_reset_code
    end
    if user = User.find_by( :password_reset_code => password_reset_code )
    # TODO: diff between (:password_reset_code => password_reset_code) AND (password_reset_code: password_reset_code)  ??
      user.password_reset_expires_at = Time.now + TIME_UNTIL_EXPIRE
      user.save
      user
    end
  end

  def update_password(password, password_confirmation)
    self.password = password
    self.password_confirmation = password_confirmation
    self.save
    self
  end

  def clear_reset_code
    self.unset(:password_reset_code)
    self.unset(:password_reset_expires_at)
    self.save
  end

  def update_profile(first_name, last_name, user_name)
    self.first_name = first_name
    self.last_name = last_name
    self.user_name = user_name
    self.save
    self
  end

  
  protected

  def encrypt_password
    self.salt = BCrypt::Engine.generate_salt
    self.fish = BCrypt::Engine.hash_secret(password, self.salt)
  end

  def downcase_email
    self.email.downcase!
  end

end