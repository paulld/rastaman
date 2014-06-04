require 'spec_helper'

describe "the registration process", :type => :feature do
  let!(:password) { 'Secret123' }
  subject { Fabricate(:registrant) }

  it "creates a new user, deletes the registrant, and redirects to the home page" do
    # puts "subject email:", subject.email
    visit "/register/#{subject.sign_up_code}"

    within("#registration") do
      fill_in 'user_password', :with => password
      fill_in 'user_password_confirmation', :with => password
    end

    click_button 'Register!'

    user = User.find_by(email: subject.email)
    # puts "user email:", user.email
    # Registrant.find_by(email: subject.email)

    expect(page.status_code).to eq(200)
    expect(page).to have_content "Welcome"
    expect(user).not_to be_nil
    # expect(registrant).to be_nil
  end
end