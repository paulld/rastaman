class Registrant
  include Mongoid::Document

  field :email
  field :sign_up_code
  field :sign_up_expires_at, type: Time

end