Registrant.destroy_all

Registrant.create([
  {
    email: "bob@example.com",
    sign_up_code: SecureRandom.urlsafe_base64,
    sign_up_expires_at: Time.now + 2.hours
  },
  {
    email: "joe@example.com",
    sign_up_code: SecureRandom.urlsafe_base64,
    sign_up_expires_at: Time.now + 2.hours
  },
  {
    email: "jake@example.com",
    sign_up_code: SecureRandom.urlsafe_base64,
    sign_up_expires_at: Time.now + 2.hours
  },
  {
    email: "jim@example.com",
    sign_up_code: SecureRandom.urlsafe_base64,
    sign_up_expires_at: Time.now + 2.hours
  },
  {
    email: "ron@example.com",
    sign_up_code: SecureRandom.urlsafe_base64,
    sign_up_expires_at: Time.now + 2.hours
  }
])