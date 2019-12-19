require "application_system_test_case"

class PinboardPinsTest < ApplicationSystemTestCase
  test 'add pin to pinboard' do
    user = User.new email: 'dummy@email.com'
    user.save!
    pin = Pin.new title: "Cat image",
                    image_url: 'http://fpoimg.com/255x170',
                    tag: 'tag',
                    user: user
    pin.save!
    visit new_user_path
    fill_in 'Email', with: 'dummy@email.com'
    click_button 'Submit'
    visit pin_path(pin)
    click_on 'Add'
    assert_equal current_path, pin_path(pin)
    assert_equal user.pinboard_pins.length, 1
    assert find('.btn .btn', text: 'ADD').disabled?
  end

  test 'no pin on pinboard' do
    visit new_user_path
    fill_in 'Email', with: 'dummy@email.com'
    click_button 'Submit'
    assert_equal current_path, user_pinboard_pins_path(User.first)
    assert page.has_content?('Your PinBoard is empty! Go pin some images!')
    refute find_all('.card').any?
  end

  test 'one pin is displayed on pinboard' do
    user = User.new email: 'dummy@email.com'
    user.save!
    pin = Pin.new title: "Cat image",
                    image_url: 'http://fpoimg.com/255x170',
                    tag: 'tag',
                    user: user
    pin.save!
    user.pinboard_pins << pin
    visit new_user_path
    fill_in 'Email', with: 'dummy@email.com'
    click_button 'Submit'
    assert_equal current_path, user_pinboard_pins_path(user)
    refute page.has_content?('Your PinBoard is empty! Go pin some images!')
    find('.display-info-on-hover').hover
    assert page.has_content?('Cat image')
  end

  test 'pins are displayed on pinboard' do
    user = User.new email: 'dummy@email.com'
    user.save!
    6.times do |i|
      pin = Pin.new title: "Image #{i+1}",
                      image_url: 'http://fpoimg.com/255x170',
                      tag: 'tag',
                      user: user
      pin.save!
      user.pinboard_pins << pin
    end
    visit new_user_path
    fill_in 'Email', with: 'dummy@email.com'
    click_button 'Submit'
    assert_equal current_path, user_pinboard_pins_path(user)
    refute page.has_content?('Your PinBoard is empty! Go pin some images!')
    assert_equal find_all('.display-info-on-hover').length, 6
  end
end
