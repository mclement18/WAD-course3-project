require "application_system_test_case"

class SearchesTest < ApplicationSystemTestCase
  test 'search' do
    user = User.new email: 'dummy@email.com'
    pin_1 = Pin.new title: "Cat image",
                    image_url: 'http://fpoimg.com/255x170',
                    user: user
    pin_1.save!
    pin_2 = Pin.new title: "Dog image",
                    image_url: 'http://fpoimg.com/255x170',
                    user: user
    pin_2.save!
    visit root_path
    fill_in 'q', with: 'Cat'
    click_button 'Search'
    assert_equal current_path, pins_path
    find('.display-info-on-hover').hover
    assert page.has_content?('Cat image')
    refute page.has_content?('Dog image')
  end

  test 'search no query, display all' do
    user = User.new email: 'dummy@email.com'
    user.save!
    6.times do |i|
      pin = Pin.new title: "Image #{i+1}",
                      image_url: 'http://fpoimg.com/255x170',
                      tag: 'tag',
                      user: user
      pin.save!
    end
    visit root_path
    click_button 'Search'
    assert page.has_content?('All Pins')
    assert_equal find_all('.display-info-on-hover').length, 6
  end

  test 'search no hit, query displayed' do
    visit root_path
    fill_in 'q', with: 'Cat'
    click_button 'Search'
    assert page.has_content?('Cat')
    assert page.has_content?('No result found!...')
  end

  test 'search for title and tags' do
    user = User.new email: 'dummy@email.com'
    pin_1 = Pin.new title: "Mountains landscape",
                    image_url: 'http://fpoimg.com/255x170',
                    tag: 'Nature Landscape',
                    user: user
    pin_1.save!
    pin_2 = Pin.new title: "View of Geneva lake",
                    image_url: 'http://fpoimg.com/255x170',
                    tag: 'Lake Landscape',
                    user: user
    pin_2.save!
    pin_3 = Pin.new title: "Dog image",
                    image_url: 'http://fpoimg.com/255x170',
                    tag: 'Animal',
                    user: user
    pin_3.save!
    visit root_path
    fill_in 'q', with: 'Landscape'
    click_button 'Search'
    matches = find_all('.display-info-on-hover')
    assert_equal matches.length, 2
    matches[0].hover
    assert page.has_content?('Mountains landscape')
    matches[1].hover
    assert page.has_content?('View of Geneva lake')
  end

  test 'search query is displayed in url' do
    visit root_path
    fill_in 'q', with: 'Cat'
    click_button 'Search'
    assert current_url.include?('q=Cat')
  end
end
