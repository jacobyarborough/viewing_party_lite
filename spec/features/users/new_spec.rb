require 'rails_helper'

RSpec.describe 'new user registration page' do
  it 'has a form to register a new user' do
    visit '/register'

    expect(current_path).to eq('/register')
    expect(page).to have_content("Register New User")
    expect(page).to have_content("Name")
    expect(page).to have_content("Email")
    expect(page).to have_content("Password")
    expect(page).to have_content("Password confirmation")
    expect(page).to have_button("Register")
  end

  it 'can register a new user' do
    visit '/register'

    fill_in :name, with: "Snoopy"
    fill_in :email, with: "snoopy@peanuts.com"
    fill_in :password, with: "Password123"
    fill_in :password_confirmation, with: "Password123"
    click_on "Register"

    expect(page).to have_content("Snoopy")
    expect(page).to have_link("Home")
    expect(page).to have_content("Welcome Snoopy")
  end

  describe 'sad path' do 
    context 'fail to enter a name' do 
      it 'redirects to the register page' do 
        visit '/register'

        fill_in :name, with: ""
        fill_in :email, with: "sally@peanuts.com"
        fill_in :password, with: "Password123"
        fill_in :password_confirmation, with: "Password123"
        
        expect(current_path).to eq('/register')
      end 
    end 

    context 'fail to enter a unique email' do 
      it 'redirects to the register page' do 
        User.create(name: 'jello', email: 'jj@hello.com', password: 'Password123', password_confirmation: 'Password123')

        visit '/register'

        fill_in :name, with: "joe joe"
        fill_in :email, with: "jj@hello.com"
        fill_in :password, with: "Password123"
        fill_in :password_confirmation, with: "Password123"
        
        expect(current_path).to eq('/register')
      end 
    end 

    context 'fail to match passwords' do 
      it 'redirects to the register page' do 
        visit '/register'

        fill_in :name, with: ""
        fill_in :email, with: "sally@peanuts.com"
        fill_in :password, with: "Password123"
        fill_in :password_confirmation, with: "Password13"
        
        expect(current_path).to eq('/register')
      end 
    end 
  end
end