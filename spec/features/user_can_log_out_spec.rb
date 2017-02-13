require 'rails_helper'

RSpec.feature "User can log out" do
  describe "as a logged in user" do
    it "When I click the Sign Out button I am sent to the login page" do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit links_path


      click_button "Sign Out"

      expect(page.current_path).to eq root_path
      expect(page).to have_content "You have successfully logged out."
    end
  end
end
