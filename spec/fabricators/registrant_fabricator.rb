Fabricator(:registrant) do
  email { Faker::Internet.email }
end

Fabricator(:registrant_with_bad_email, from: :registrant) do
  email { "bad email" }
end

Fabricator(:registrant_with_blank_email, from: :registrant) do
  email { nil }
end