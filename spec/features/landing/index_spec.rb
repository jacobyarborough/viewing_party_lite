require 'rails_helper'

RSpec.describe 'landing page' do 
  describe 'happy path functionality' do
    let!(:users) { create_list(:user, 2, password: 'password1', password_confirmation: 'password1') }

    before(:each) do
      visit root_path
    end 

    context 'when there are existing users and a user is logged in' do 
      it 'shows all existing users' do 
        visit "/login"
        fill_in :email, with: users.first.email
        fill_in :password, with: users.first.password
        click_button "Login"
        visit root_path

        within "#users" do
          expect(page).to have_content("Existing Users:")
          expect(page).to have_content(users[0][:email])
          expect(page).to have_content(users[1][:email])
        end
      end 

      it 'has a logout button' do 
        visit "/login"
        fill_in :email, with: users.first.email
        fill_in :password, with: users.first.password
        click_button "Login"
        visit root_path

        click_button "Logout"

        expect(current_path).to eq(root_path)
      end 
    end 

    it 'has a button to create a new user' do 
      within "#new-user-button" do
        expect(page).to have_button("Create a New User")
      end 
    end 

    it 'has a link to go to the home page' do 
      click_link "Home"
      
      expect(current_path).to eq(root_path)
    end 

    it 'shows the application name' do 
      expect(page).to have_content("Viewing Party Lite")
    end 

    it 'has a link to the login page' do 
      click_button "Login"

      expect(current_path).to eq('/login')
    end 
  end 
end 