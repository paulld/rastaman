class Registrant
  include Mongoid::Document

  TIME_UNTIL_EXPIRE = 2.hours

  # before_create :check_for_previous_attempt
  before_create :set_sign_up_code_and_expiration
  before_save :downcase_email

  field :email
  field :sign_up_code
  field :sign_up_expires_at, type: Time

  # validates :email, presence: true, format: { with: EMAIL_REGEX }
  validates :email, presence: true
  validates :email, format: { with: EMAIL_REGEX }

  protected

  def set_sign_up_code_and_expiration
    self.sign_up_code = SecureRandom.urlsafe_base64
    self.sign_up_expires_at = Time.now + TIME_UNTIL_EXPIRE
  end

  # def check_for_duplicate_email
  #   begin
  #     self = Registrant.find_by( email: self.email )
  #   rescue
  #   end
  # end

  def downcase_email
    self.email.downcase!
  end

end
