require 'spec_helper'

describe "About page", :type => :feature do
  
  it "has an 'About this App' title" do
    visit '/about-us'
    # page.should have_css('h1', text: 'About this App')
    expect(page).to have_css('h1', text: 'About this App')
  end

  it "contains the text 'Web Development Immersive'" do
    visit '/about-us'
    # page.should have_content("Web Development Immersive")
    expect(page).to have_content "Web Development Immersive"
  end

  it "has a link to GA website" do
    visit '/about-us'
    # page.should have_link('WDI at General Assembly', href: 'https://generalassemb.ly/education/web-development-immersive')
    expect(page).to have_link('WDI at General Assembly', href: 'https://generalassemb.ly/education/web-development-immersive')
  end
end