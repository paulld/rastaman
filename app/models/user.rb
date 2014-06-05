require 'bcrypt'

class User
  include Mongoid::Document

  before_save :encrypt_password

  attr_accessor :password, :password_confirmation

  field :email
  field :salt
  field :fish
  # some fields here for resetting the password

  validates :email, presence: true, format: { with: EMAIL_REGEX }
  # validates :password, confirmation: true

  
  def authenticate(password)
    self.fish == BCrypt::Engine.hash_secret(password, self.salt)
  end

  # def self.authenticate(email, password)
  #   user = User.find_by( email: email )

  #   user if user && user.authenticate(password)
  # end

  protected

  def encrypt_password
    self.salt = BCrypt::Engine.generate_salt
    self.fish = BCrypt::Engine.hash_secret(password, self.salt)
  end

  def downcase_email
    self.email.downcase!
  end
end