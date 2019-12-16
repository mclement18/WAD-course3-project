require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  test 'create user with form' do
    visit new_user_path
    fill_in 'Email', with: 'dummy@email.com'
    click_button 'Submit'
    assert_equal current_path, about_index_path
    assert_equal User.first.email, 'dummy@email.com'
  end

  test 'user log in' do
    user = User.new email: 'dummy@email.com'
    user.save!
    visit new_user_path
    fill_in 'Email', with: 'dummy@email.com'
    click_button 'Submit'
    assert_equal current_path, about_index_path
    assert_equal User.all.length, 1
  end

  test 'create user without email' do
    visit new_user_path
    click_button 'Submit'
    assert_equal current_path, new_user_path
  end

  test 'create user with invalid email' do
    visit new_user_path
    fill_in 'Email', with: 'notanemail'
    click_button 'Submit'
    assert_equal current_path, new_user_path
  end

  test 'create user with invalid email 2' do
    visit new_user_path
    fill_in 'Email', with: 'wrong@email'
    click_button 'Submit'
    assert page.has_content?('Email is not an email')
  end
end
