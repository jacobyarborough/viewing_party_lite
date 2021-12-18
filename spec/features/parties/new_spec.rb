require 'rails_helper'

RSpec.describe 'create viewing party' do
  context 'happy path' do
    it 'allows user to create a viewing party' do
      VCR.use_cassette('moviedb_movies_4', re_record_interval: 7.days) do
        user = User.create!(name: "Snoopy", email: "snoopy@peanuts.com", password: 'Password1', password_confirmation: 'Password1')

        visit "/login"
        fill_in :email, with: user.email
        fill_in :password, with: user.password
        click_button "Login"

        visit "/movies/2/party/new"

        fill_in :movie_title, with: "Ariel"
        fill_in :duration, with: 73
        fill_in :start_date, with: '12/03/2021'
        fill_in :start_time, with: '08:30 PM'
        choose(nil)
        click_button 'Create Party'

        expect(page.status_code).to eq 200
        expect(page).to have_content("Ariel")
        expect(page).to have_content("December 3, 2021")
        expect(page).to have_content("8:30 PM")
      end
    end
  end

  context 'sad path' do 
    it 'does not allow a user to create a party without being logged in' do
      VCR.use_cassette('moviedb_movies_4', re_record_interval: 7.days) do

        visit "/movies/2"

        click_button "Create a Viewing Party"

        expect(page).to have_content("You must be signed in and/or register in order to access the page you are trying to reach")
        expect(current_path).to eq('/discover')
      end
    end 
  end 
end