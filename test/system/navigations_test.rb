require "application_system_test_case"

class NavigationsTest < ApplicationSystemTestCase
  test 'visitor navigation' do
    pin = Pin.new title: "Cat image",
                    image_url: 'http://fpoimg.com/255x170',
                    tag: 'tag',
                    user: User.new(email: 'dummy@email.com')
    pin.save!
    visit root_path
    assert page.has_content?('Log in / Register')
    refute page.has_content?('My PinBoard')
    refute page.has_content?('Create Pin')
    click_on 'About'
    assert_equal current_path, about_index_path
    assert page.has_content?('Log in / Register')
    refute page.has_content?('My PinBoard')
    click_on 'See All'
    assert_equal current_path, pins_path
    assert page.has_content?('Log in / Register')
    refute page.has_content?('My PinBoard')
    fill_in 'q', with: 'cat'
    click_on 'Search'
    assert_equal current_path, pins_path
    assert page.has_content?('Log in / Register')
    refute page.has_content?('My PinBoard')
    find('.display-info-on-hover').click
    assert_equal current_path, pin_path(pin)
    assert page.has_content?('Log in / Register')
    refute page.has_content?('My PinBoard')
    click_on 'Log in / Register'
    assert_equal current_path, new_user_path
    assert page.has_content?('Log in / Register')
    refute page.has_content?('My PinBoard')
    click_on 'Pin Your Images', match: :first
    assert_equal current_path, root_path
  end

  test 'user navigation' do
    pin = Pin.new title: "Cat image",
                    image_url: 'http://fpoimg.com/255x170',
                    tag: 'tag',
                    user: User.new(email: 'dummy@email.com')
    pin.save!
    visit root_path
    assert page.has_content?('Log in / Register')
    refute page.has_content?('My PinBoard')
    click_on 'Log in / Register'
    assert_equal current_path, new_user_path
    assert page.has_content?('Log in / Register')
    refute page.has_content?('My PinBoard')
    fill_in 'Email', with: 'dummy@email.com'
    click_on 'Submit'
    assert_equal current_path, user_pinboard_pins_path(User.first)
    assert page.has_content?('My PinBoard')
    assert page.has_content?('Create Pin')
    refute page.has_content?('Log in / Register')
    click_on 'About'
    assert_equal current_path, about_index_path
    assert page.has_content?('My PinBoard')
    refute page.has_content?('Log in / Register')
    click_on 'See All'
    assert_equal current_path, pins_path
    assert page.has_content?('My PinBoard')
    refute page.has_content?('Log in / Register')
    fill_in 'q', with: 'cat'
    click_on 'Search'
    assert_equal current_path, pins_path
    assert page.has_content?('My PinBoard')
    refute page.has_content?('Log in / Register')
    find('.display-info-on-hover').click
    assert_equal current_path, pin_path(pin)
    assert page.has_content?('My PinBoard')
    refute page.has_content?('Log in / Register')
    click_on 'Edit'
    assert_equal current_path, edit_pin_path(pin)
    assert page.has_content?('My PinBoard')
    refute page.has_content?('Log in / Register')
    click_on 'Create Pin'
    assert_equal current_path, new_pin_path
    assert page.has_content?('My PinBoard')
    click_on 'My PinBoard'
    assert_equal current_path, user_pinboard_pins_path(User.first)
    click_on 'Pin Your Images', match: :first
    assert_equal current_path, root_path
  end

  test 'visitor cannot access new_pin_path' do
    visit new_pin_path
    refute_equal current_path, new_pin_path
    assert_equal current_path, new_user_path
  end

  test 'visitor cannot access user_pinboard_pins_path' do
    user = User.new email: 'dummy@email.com'
    user.save!
    visit user_pinboard_pins_path(user)
    refute_equal current_path, user_pinboard_pins_path(user)
    assert_equal current_path, new_user_path
  end

  test 'visitor cannot access edit_pin_path' do
    pin = Pin.new title: "Cat image",
                    image_url: 'http://fpoimg.com/255x170',
                    tag: 'tag',
                    user: User.new(email: 'dummy@email.com')
    pin.save!
    visit edit_pin_path(pin)
    refute_equal current_path, edit_pin_path(pin)
    assert_equal current_path, new_user_path
  end

  test 'user cannot relog in' do
    visit new_user_path
    fill_in 'Email', with: 'dummy@email.com'
    click_on 'Submit'
    visit new_user_path
    refute_equal current_path, new_user_path
    assert_equal current_path, user_pinboard_pins_path(User.first)
  end

  test 'Back to Top link' do
    visit root_path
    click_on 'Back to Top'
    assert current_url.include?('#top')
  end
end
