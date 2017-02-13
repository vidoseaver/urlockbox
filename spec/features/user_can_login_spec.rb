require 'rails_helper'

RSpec.feature "User can log in" do
  describe "as a guest when I enter my email correctly" do
    it "I am logged in and taken to the login page" do
      user = create(:user)

      visit root_path

      fill_in "email", with: user.email
      fill_in "password", with: user.password

      click_button "Login"


      expect(page.current_path).to eq(links_path)
      expect(page).to have_content "Welcome #{user.email}"
    end
  end
  describe "as a guest when I enter my email incorrectly" do
    it "I am redirected to the login page and flashed appropriately" do
      user = create(:user)

      visit root_path

      fill_in "email", with: "cheeststeaks"
      fill_in "password", with: user.password_digest

      click_button "Login"

      expect(page.current_path).to eq(new_session_path)
      expect(page).to have_content "Incorrect email"
    end
  end
  describe "as a guest when I enter my password incorrectly" do
    it "I am redirected to the login page and flashed appropriately" do
      user = create(:user)

      visit root_path

      fill_in "email", with: user.email
      fill_in "password", with: "notmypassword"

      click_button "Login"

      expect(page.current_path).to eq(new_session_path)
      expect(page).to have_content "Incorrect password"
    end
  end
end
