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
end
