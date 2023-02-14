require 'rails_helper'

RSpec.describe 'Landing Page' do
  before :each do
    user1 = User.create(name: 'User One', email: 'user1@test.com', password_digest: 'password')
    user2 = User.create(name: 'User Two', email: 'user2@test.com', password_digest: 'password')
    visit '/'
  end

  it 'has a header' do
    expect(page).to have_content('Viewing Party Lite')
  end

  it 'has links/buttons that link to correct pages' do
    click_button 'Create New User'

    expect(current_path).to eq(register_path)

    visit '/'

    click_link 'Home'
    expect(current_path).to eq(root_path)
  end

  it 'lists out existing users' do
    user1 = User.create(name: 'User One', email: 'user1@test.com', password_digest: 'password',
                        password_confirmation: 'password')
    user2 = User.create(name: 'User Two', email: 'user2@test.com', password_digest: 'password',
                        password_confirmation: 'password')
    expect(page).to have_content('Existing Users:')

    within('.existing-users') do
      expect(page).to have_content(user1.email)
      expect(page).to have_content(user2.email)
    end
  end

  it 'can log in with valid credentials' do
    user1 = User.create(name: 'User Four', email: 'user4@test.com', password: 'password')
    visit '/'

    click_on 'Log in'

    expect(current_path).to eq(login_path)
    fill_in :email, with: user1.email
    fill_in :password, with: user1.password

    click_on 'Log In'

    expect(current_path).to eq(user_path(user1))
  end

  it 'cannot log in with bad credentials' do
    user1 = User.create(name: 'User Four', email: 'user4@test.com', password: 'password')

    visit login_path
    fill_in :email, with: user1.email
    fill_in :password, with: 'bad password'

    click_on 'Log In'

    expect(current_path).to eq(login_path)

    expect(page).to have_content('Sorry, your credentials are bad.')
  end
end
