require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'Online Class'" do
      visit '/static_pages/home'
      expect(page).not_to have_content('Online Class')
    end

    it "should have the title 'Home'" do
      visit '/static_pages/home'
      expect(page).to have_title("良师益友")
    end
  end

  describe "Help page" do

    it "should have the content 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_content('帮助')
    end

    it "should have the title 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_title("良师益友 | 帮助")
    end
  end

  describe "About page" do

    it "should have the content 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_content('关于我们')
    end

    it "should have the title 'About Us'" do
      visit '/static_pages/about'
      expect(page).to have_title("关于我们")
    end
  end
end