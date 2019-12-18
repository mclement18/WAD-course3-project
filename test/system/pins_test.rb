require "application_system_test_case"

class PinsTest < ApplicationSystemTestCase
  test 'create new pinned image' do
    user = User.new email: 'dummy@email.com'
    user.save!
    visit new_user_path
    fill_in 'Email', with: 'dummy@email.com'
    click_button 'Submit'
    assert_equal current_path, root_path
    visit new_pin_path
    fill_in 'Title', with: 'An image'
    fill_in 'Image url', with: 'http://fpoimg.com/255x170'
    fill_in 'Tag', with: 'A tag'
    click_button 'Create Pin'
    assert_equal current_path, pins_path
    find('.display-info-on-hover').hover
    assert page.has_content?('An image')
  end

  test 'create two pinned images' do
    user = User.new email: 'dummy@email.com'
    user.save!
    2.times do |i|
      pin = Pin.new title: "Image #{i+1}",
                      image_url: 'http://fpoimg.com/255x170',
                      tag: 'tag',
                      user: user
      pin.save!
    end
    visit pins_path
    matches = find_all('.display-info-on-hover')
    assert_equal matches.length, 2
    matches.first.hover
    assert page.has_content?('Image 1')
    matches.last.hover
    assert page.has_content?('Image 2')
  end

  test 'home page' do
    user = User.new email: 'dummy@email.com'
    7.times do |i|
      pin = Pin.new title: "A pin #{i+1}",
                    image_url: 'http://fpoimg.com/255x170',
                    tag: 'tag',
                    user: user
      pin.save!
    end
    visit root_path
    matches = find_all('.display-info-on-hover')
    assert_equal matches.length, 6
    6.times do |i|
      matches[i].hover
      assert page.has_content?("A pin #{(i-7).abs}")
    end
  end

  test 'create pinned image, title is requiered' do
    user = User.new email: 'dummy@email.com'
    user.save!
    visit new_user_path
    fill_in 'Email', with: 'dummy@email.com'
    click_button 'Submit'
    assert_equal current_path, root_path
    visit new_pin_path
    fill_in 'Image url', with: 'http://fpoimg.com/255x170'
    fill_in 'Tag', with: 'A tag'
    click_button 'Create Pin'
    assert_equal current_path, new_pin_path
  end

  test 'create pinned image, image_url is requiered' do
    user = User.new email: 'dummy@email.com'
    user.save!
    visit new_user_path
    fill_in 'Email', with: 'dummy@email.com'
    click_button 'Submit'
    assert_equal current_path, root_path
    visit new_pin_path
    fill_in 'Title', with: 'An image'
    fill_in 'Tag', with: 'A tag'
    click_button 'Create Pin'
    assert_equal current_path, new_pin_path
  end

  test 'create pinned image, tag too long' do
    user = User.new email: 'dummy@email.com'
    user.save!
    visit new_user_path
    fill_in 'Email', with: 'dummy@email.com'
    click_button 'Submit'
    assert_equal current_path, root_path
    visit new_pin_path
    fill_in 'Title', with: 'An image'
    fill_in 'Image url', with: 'http://fpoimg.com/255x170'
    fill_in 'Tag', with: 'tag is way more than 30 characters long'
    click_button 'Create Pin'
    assert page.has_content?('Tag is too long')
  end

  test 'update pinned image title' do
    pin = Pin.new title: "Cat image",
                    image_url: 'http://fpoimg.com/255x170',
                    tag: 'tag',
                    user: User.new(email: 'dummy@email.com')
    pin.save!
    visit new_user_path
    fill_in 'Email', with: 'dummy@email.com'
    click_button 'Submit'
    visit edit_pin_path(pin)
    fill_in 'Title', with: 'Dog image'
    click_button 'Update Pin'
    assert_equal current_path, pin_path(pin)
    assert page.has_content?('Dog image')
  end

  test 'update pinned image tag' do
    pin = Pin.new title: "Cat image",
                    image_url: 'http://fpoimg.com/255x170',
                    tag: 'tag',
                    user: User.new(email: 'dummy@email.com')
    pin.save!
    visit new_user_path
    fill_in 'Email', with: 'dummy@email.com'
    click_button 'Submit'
    visit edit_pin_path(pin)
    fill_in 'Tag', with: 'Animal'
    click_button 'Update Pin'
    assert_equal current_path, pin_path(pin)
    assert page.has_content?('Animal')
  end

  test 'update pinned image tag, tag too long' do
    pin = Pin.new title: "Cat image",
                    image_url: 'http://fpoimg.com/255x170',
                    tag: 'tag',
                    user: User.new(email: 'dummy@email.com')
    pin.save!
    visit new_user_path
    fill_in 'Email', with: 'dummy@email.com'
    click_button 'Submit'
    visit edit_pin_path(pin)
    fill_in 'Tag', with: 'tag is way more than 30 characters long'
    click_button 'Update Pin'
    assert page.has_content?('Tag is too long')
  end
end
