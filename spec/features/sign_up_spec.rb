require 'spec_helper'

describe "Sign up process", :type => :feature do
  let!(:email) { 'user@example.com' }

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