require "application_system_test_case"

class ShowPinsTest < ApplicationSystemTestCase
  test 'click on image open image details page' do
    user = User.new email: 'dummy@email.com'
    pin = Pin.new title: "Cat image",
                    image_url: 'http://fpoimg.com/255x170',
                    tag: 'tag',
                    user: user
    pin.save!
    visit pins_path
    find('.display-info-on-hover').click
    assert_equal current_path, pin_path(pin)
    assert page.has_content?('Cat image')
    assert page.has_content?('tag')
    assert page.has_content?(user.email)
  end

  test 'edit and add button are displayed to logged user' do
    pin = Pin.new title: "Cat image",
                    image_url: 'http://fpoimg.com/255x170',
                    tag: 'tag',
                    user: User.new(email: 'dummy@email.com')
    pin.save!
    visit new_user_path
    fill_in 'Email', with: 'dummy@email.com'
    click_button 'Submit'
    visit pin_path(pin)
    assert page.has_content?('EDIT')
    assert page.has_content?('ADD')
  end

  test 'edit and add button are NOT displayed to visitors' do
    pin = Pin.new title: "Cat image",
                    image_url: 'http://fpoimg.com/255x170',
                    tag: 'tag',
                    user: User.new(email: 'dummy@email.com')
    pin.save!
    visit pin_path(pin)
    refute page.has_content?('EDIT')
    refute page.has_content?('ADD')
  end
end
