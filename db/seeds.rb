Registrant.destroy_all

Registrant.create([
  {
    email: "bob@example.com",
    registration_code: SecureRandom.urlsafe_base64,
    registration_expires_at: Time.now + 2.hours
  },
  {
    email: "joe@example.com",
    registration_code: SecureRandom.urlsafe_base64,
    registration_expires_at: Time.now + 2.hours
  },
  {
    email: "jake@example.com",
    registration_code: SecureRandom.urlsafe_base64,
    registration_expires_at: Time.now + 2.hours
  },
  {
    email: "jim@example.com",
    registration_code: SecureRandom.urlsafe_base64,
    registration_expires_at: Time.now + 2.hours
  },
  {
    email: "ron@example.com",
    registration_code: SecureRandom.urlsafe_base64,
    registration_expires_at: Time.now + 2.hours
  }
])