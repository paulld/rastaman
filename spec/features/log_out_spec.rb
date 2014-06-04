require 'spec_helper'

describe "log out", :type => :feature do
  it "logs the user out and redirects to the log in page" do
    page.set_rack_session(:user_id => 1)

    visit '/logout'

    expect(page.get_rack_session["user_id"]).to be_nil
  end
end