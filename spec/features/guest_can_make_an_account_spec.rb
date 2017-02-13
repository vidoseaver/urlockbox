require 'rails_helper'

RSpec.feature "User can create an account" do
  describe "as a guest when I try to sign up" do
    it "with a unique email and the same passwords I go to dashboard" do

      visit "/users/new"


      fill_in("user[email]", with: "joe.e@gmail.com")
      fill_in("user[password]", with: "password")
      fill_in("user[password_confirmation]", with: "password")


      click_on("Submit")
      expect(page.current_path).to eq(links_path)
    end

    it "with non matching passwords i get redirected to the sign up page and flashed accordingly" do
      visit "/users/new"


      fill_in("user[email]", with: "joe.e@gmail.com")
      fill_in("user[password]", with: "password")
      fill_in("user[password_confirmation]", with: "wrong")
      click_on("Submit")


      expect(page.current_path).to eq("/users/new")
      expect(page).to have_content("The passwords you entered mismatched")
    end
    it "with an already used email, get redirected to sign up and flashed accordlingly" do
      user = create(:user)
      visit "/users/new"


      fill_in("user[email]", with: "#{user.email}")
      fill_in("user[password]", with: "#{user.password}")
      fill_in("user[password_confirmation]", with: "#{user.password}")

      click_on("Submit")


      expect(page.current_path).to eq("/users/new")
      expect(page).to have_content("That email has already been taken")
    end
  end
end
