require 'rails_helper'

RSpec.describe 'movie show page' do
  describe 'happy path' do
    it 'shows movie data' do
      VCR.use_cassette('moviedb_movies_3', re_record_interval: 7.days) do
        user = User.create!(name: "Snoopy", email: "snoopy@peanuts.com", password: 'Password1', password_confirmation: 'Password1')

        visit "/login"
        fill_in :email, with: user.email
        fill_in :password, with: user.password
        click_button "Login"

        visit "/movies/120"

        expect(page.status_code).to eq 200
        expect(page).to have_content("The Lord of the Rings: The Fellowship of the Ring")
        expect(page).to have_content("Sean Bean : Boromir")
        expect(page).to have_content("LadyGreenEyes:")
        expect(page).to have_button("Create a Viewing Party")
      end
    end
  end
end