require 'rails_helper'

RSpec.describe 'login page' do 
  let!(:users) { create_list(:user, 2, password: 'password1', password_confirmation: 'password1') }

  before(:each) do
    visit '/login'
  end 
  context 'happy path functionality' do
    it 'will successfully login when passwords match for an existing user' do 
      fill_in :email, with: users.first.email
      fill_in :password, with: 'password1'

      click_button "Login"

      expect(current_path).to eq("/dashboard")
    end 
  end 

  context 'sad path functionality' do 
    it 'will return user to login page if passwords do not match' do 
      fill_in :email, with: users.first.email
      fill_in :password, with: 'password'

      click_button "Login"

      expect(current_path).to eq("/login")
    end 

    # it 'will return user to login page if email is left blank' do 
    #   fill_in :email, with: ""
    #   fill_in :password, with: 'password1'

    #   click_button "Login"

    #   expect(current_path).to eq("/login")
    # end 
  end 
end 