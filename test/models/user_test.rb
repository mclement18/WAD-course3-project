require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'one user created' do
    user = User.new email: 'dummy@email.com'
    user.save!
    assert_equal User.first, user
  end

  test 'two users created' do
    user_1 = User.new email: 'dummy1@email.com'
    user_1.save!
    user_2 = User.new email: 'dummy2@email.com'
    user_2.save!
    assert_equal User.all.length, 2
  end

  test 'users must have an email' do
    user = User.new
    refute user.valid?
  end

  test 'users must have a valid email' do
    user_1 = User.new email: 'nonvalid.email'
    user_2 = User.new email: 'nonvalid@ds@email.com'
    user_3 = User.new email: 'nonvalid@email'
    user_4 = User.new email: 'nonvalid@emai!l.com'
    refute user_1.valid?
    refute user_2.valid?
    refute user_3.valid?
    refute user_4.valid?
  end

  test 'user email must be unique' do
    user_1 = User.new email: 'dummy@email.com'
    user_1.save!
    user_2 = User.new email: 'dummy@email.com'
    refute user_2.valid?
  end

  test 'user has no pin in pinboard' do
    user = User.new email: 'dummy@email.com'
    user.save!
    assert_empty user.pinboard_pins
  end

  test 'user has two pins in pinboard' do
    user = User.new email: 'dummy@email.com'
    user.save!
    pin_1 = Pin.new title: 'Cat funny image',
                    image_url: 'image/url',
                    tag: 'Animal',
                    user: user
    pin_1.save!
    pin_2 = Pin.new title: 'Dog image',
                    image_url: 'image/url',
                    tag: 'Animal Funny',
                    user: user
    pin_2.save!
    user.pinboard_pins << pin_1
    user.pinboard_pins << pin_2
    assert_equal user.pinboard_pins.length, 2
  end

  test 'user pinboard is ordered' do
    user = User.new email: 'dummy@email.com'
    user.save!
    pin_1 = Pin.new title: 'Cat funny image',
                    image_url: 'image/url',
                    tag: 'Animal',
                    user: user
    pin_1.save!
    pin_2 = Pin.new title: 'Dog image',
                    image_url: 'image/url',
                    tag: 'Animal Funny',
                    user: user
    pin_2.save!
    user.pinboard_pins << pin_1
    user.pinboard_pins << pin_2
    assert_equal user.pinboard_pins.first, pin_1
  end
end
