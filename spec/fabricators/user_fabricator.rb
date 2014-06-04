Fabricator(:user) do
  email { Faker::Internet.email }
  password { "1234567" }
  password_confirmation { "1234567" }
end

Fabricator(:user_with_bad_email, from: :user) do
  email { "bad email" }
end

Fabricator(:user_with_blank_email, from: :user) do
  email { nil }
end

