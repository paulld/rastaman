require 'spec_helper'

describe "the registration process", :type => :feature do
  let!(:password) { 'secret' }
  subject { Fabricate(:registrant) }

  it "creates a new user and deletes the registrant" do
    visit "/register/#{subject.sign_up_code}"

    within("#registration") do
      fill_in 'user_password', :with => password
      fill_in 'user_password_confirmation', :with => password
    end

    click_button 'Register!'

    # registrant = Registrant.find_by(email: email)

    expect(page.status_code).to eq(200)
    expect(page).to have_content "Welcome"
  end
end