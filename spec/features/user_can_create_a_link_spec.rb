require 'rails_helper'

RSpec.feature "User adds a link" do
  describe "User enters valid link and title" do
    it "adds the link refreshes and shows the link as unread" do
        user = create(:user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit links_path

        fill_in "link[title]", with: "Google"
        fill_in "link[url]" ,  with: "http://www.google.com"

        click_button "Submit"

        expect(page.current_path).to eq(links_path)
        expect(page).to have_content("Link Added!")
        expect(page).to have_content("Google")
        expect(page).to have_content("www.google.com")
        expect(page).to have_button("Mark as Read")
    end

    it "does not add the link if the url is not a real valid" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit links_path

      fill_in "link[title]", with: "Google"
      fill_in "link[url]" ,  with: "www.google"

      click_button "Submit"

      expect(page.current_path).to eq(links_path)

      expect(page).to have_content("Invalid Url Bro!")
      expect(page).to_not have_content("Google")
      expect(page).to_not have_content("www.google")
    end

    it "does not add the link if the title doesnt exist" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit links_path

      fill_in "link[url]" ,  with: "http://www.google.com"

      click_button "Submit"

      expect(page.current_path).to eq(links_path)
      expect(page).to have_content("You need a title Bro!")
      expect(page).to_not have_content("Google")
      expect(page).to_not have_content("www.google")
    end
  end
end
