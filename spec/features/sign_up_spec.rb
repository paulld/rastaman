require 'spec_helper'

describe "Sign up process", :type => :feature do
  # let!(:email) { 'user@example.com' }
  let!(:email) { Faker::Internet.email }

  it "signs me up" do
    visit '/login'

    within("#login") do
      fill_in 'registrant_email', :with => email
    end

    click_button 'Sign up'

    registrant = Registrant.find_by(email: email)

    expect(page.status_code).to eq(201)
    expect(registrant.email).to eq(email)
  end

end

#  ADDED BY CHARLES : TO BE TESTED!!!!!!!!

# feature 'Visitor signs up' do
#   scenario 'with valid email and password' do
#     sign_up_with 'valid@example.com', 'password'

#     expect(page).to have_content('Sign out')
#   end

#   scenario 'with invalid email' do
#     sign_up_with 'invalid_email', 'password'

#     expect(page).to have_content('Sign in')
#   end

#   scenario 'with blank password' do
#     sign_up_with 'valid@example.com', ''

#     expect(page).to have_content('Sign in')
#   end

#   def sign_up_with(email)
#     visit login_path
#     fill_in 'registrant_email', with: email
#     click_button 'Sign up'
#   end
# end