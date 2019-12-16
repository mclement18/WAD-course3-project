require 'test_helper'

class PinTest < ActiveSupport::TestCase
  test 'one pin created' do
    pin = Pin.new title: 'A pin',
                  image_url: 'image/url',
                  tag: 'tag',
                  user: User.new(email: 'dummy@email.com')
    pin.save!
    assert_equal pin, Pin.first
  end

  test '6 pins created' do
    user = User.new email: 'dummy@email.com'
    6.times do |i|
      pin = Pin.new title: "A pin #{i+1}",
                    image_url: 'image/url',
                    tag: 'tag',
                    user: user
      pin.save!
    end
    assert_equal Pin.all.length, 6
    assert_equal Pin.last.title, 'A pin 6'
  end

  test 'title is requiered upon creation' do
    pin = Pin.new image_url: 'image/url',
                  user: User.new(email: 'dummy@email.com')
    refute pin.valid?
  end

  test 'image_url is requiered upon creation' do
    pin = Pin.new title: 'A pin',
                  user: User.new(email: 'dummy@email.com')
    refute pin.valid?
  end

  test 'user is requiered upon creation' do
    pin = Pin.new title: 'A pin',
                  image_url: 'image/url'
    refute pin.valid?
  end

  test 'tag cannot be more than 30 characters upon creation' do
    pin = Pin.new title: 'A pin',
                  image_url: 'image/url',
                  tag: 'tag is way more than 30 characters long',
                  user: User.new(email: 'dummy@email.com')
    refute pin.valid?
  end

  test 'title is requiered upon update' do
    pin = Pin.new title: 'A pin',
                  image_url: 'image/url',
                  tag: 'tag',
                  user: User.new(email: 'dummy@email.com')
    pin.save!
    refute pin.update(title: '')
  end

  test 'image_url is requiered upon update' do
    pin = Pin.new title: 'A pin',
                  image_url: 'image/url',
                  tag: 'tag',
                  user: User.new(email: 'dummy@email.com')
    pin.save!
    refute pin.update(image_url: '')
  end

  test 'tag cannot be more than 30 characters upon update' do
    pin = Pin.new title: 'A pin',
                  image_url: 'image/url',
                  tag: 'tag',
                  user: User.new(email: 'dummy@email.com')
    pin.save!
    refute pin.update(tag: 'tag is way more than 30 characters long')
  end

  test 'most_recent no pin' do
    assert_empty Pin.most_recent
  end

  test 'most_recent method 3 pins' do
    user = User.new email: 'dummy@email.com'
    3.times do |i|
      pin = Pin.new title: "A pin #{i+1}",
                    image_url: 'image/url',
                    tag: 'tag',
                    user: user
      pin.save!
    end
    assert_equal Pin.all.length, 3
    assert_equal Pin.most_recent.length, 3
    assert_equal Pin.most_recent.first.title, 'A pin 3'
    assert_equal Pin.most_recent.last.title, 'A pin 1'
  end

  test 'most_recent method 7 pins' do
    user = User.new email: 'dummy@email.com'
    7.times do |i|
      pin = Pin.new title: "A pin #{i+1}",
                    image_url: 'image/url',
                    tag: 'tag',
                    user: user
      pin.save!
    end
    assert_equal Pin.all.length, 7
    assert_equal Pin.most_recent.length, 6
    assert_equal Pin.most_recent.first.title, 'A pin 7'
    assert_equal Pin.most_recent.last.title, 'A pin 2'
  end
end
