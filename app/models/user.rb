require 'bcrypt'

class User
  include Mongoid::Document

  before_save :encrypt_password

  attr_accessor :password, :password_confirmation

  field :email
  field :salt
  field :fish

  validates :email, presence: true, format: { with: EMAIL_REGEX }

  
  def authenticate(password)
    # encrypt the passed-in password with the user's salt
    # and compare it to the user's "fish"
    # return true if they match, false if they don't
    
    self.fish == BCrypt::Engine.hash_secret(password, self.salt)

  end


  protected

  def encrypt_password
    self.salt = BCrypt::Engine.generate_salt
    self.fish = BCrypt::Engine.hash_secret(password, self.salt)
  end
end