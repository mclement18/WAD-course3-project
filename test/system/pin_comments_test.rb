require "application_system_test_case"

class PinCommentsTest < ApplicationSystemTestCase
  test 'no comment displayed' do
    user = User.new email: 'dummy@email.com'
    pin = Pin.new title: "Cat image",
                    image_url: 'http://fpoimg.com/255x170',
                    tag: 'tag',
                    user: user
    pin.save!
    visit pin_path(pin)
    assert page.has_content?('Comments')
    assert page.has_content?('0 comment')
  end

  test 'One comment displayed on pin details page' do
    user = User.new email: 'dummy@email.com'
    pin = Pin.new title: "Cat image",
                    image_url: 'http://fpoimg.com/255x170',
                    tag: 'tag',
                    user: user
    comment = Comment.new body: "It is so cute!", 
                            pin: pin, 
                            user: user
    pin.comments << comment
    pin.save!
    visit pin_path(pin)
    assert page.has_content?('Comments')
    assert page.has_content?('1 comment')
    assert page.has_content?('It is so cute!')
  end
  
  test 'Two comments displayed on pin details page' do
    user = User.new email: 'dummy@email.com'
    pin = Pin.new title: "Cat image",
                    image_url: 'http://fpoimg.com/255x170',
                    tag: 'tag',
                    user: user
    comment_1 = Comment.new body: "It is so cute!", 
                            pin: pin, 
                            user: user
    comment_2 = Comment.new body: "Cats are always great!", 
                            pin: pin, 
                            user: user
    pin.comments << comment_1
    pin.comments << comment_2
    pin.save!
    visit pin_path(pin)
    assert page.has_content?('Comments')
    assert page.has_content?('2 comments')
    assert page.has_content?('It is so cute!')
    assert page.has_content?('Cats are always great!')
  end

  test 'user email is displayed on comment' do
    user_1 = User.new email: 'dummy@email.com'
    user_2 = User.new email: 'another@email.com'
    pin = Pin.new title: "Cat image",
                    image_url: 'http://fpoimg.com/255x170',
                    tag: 'tag',
                    user: user_1
    comment = Comment.new body: "It is so cute!", 
                            pin: pin, 
                            user: user_2
    pin.comments << comment
    pin.save!
    visit pin_path(pin)
    assert page.has_content?('Comments')
    assert page.has_content?('1 comment')
    assert page.has_content?('It is so cute!')
    assert page.has_content?(user_2.email)
  end

  test 'comment creation date is displayed' do
    user = User.new email: 'dummy@email.com'
    pin = Pin.new title: "Cat image",
                    image_url: 'http://fpoimg.com/255x170',
                    tag: 'tag',
                    user: user
    comment = Comment.new body: "It is so cute!", 
                            pin: pin, 
                            user: user
    pin.comments << comment
    pin.save!
    visit pin_path(pin)
    assert page.has_content?('Comments')
    assert page.has_content?('1 comment')
    assert page.has_content?('It is so cute!')
    assert page.has_content?(comment.created_at.strftime("%d %b '%y"))
  end
end
