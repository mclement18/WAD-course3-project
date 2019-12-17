require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test 'comment body is requiered' do
    user = User.new email: 'dummy@email.com'
    pin = Pin.new title: 'Cat funny image',
                  image_url: 'image/url',
                  tag: 'Animal',
                  user: user
    pin.save!
    comment = Comment.new pin: pin, 
                          user: user
    refute comment.valid?
  end

  test 'comment body cannot be more than 500 characters long' do
    user = User.new email: 'dummy@email.com'
    pin = Pin.new title: 'Cat funny image',
                  image_url: 'image/url',
                  tag: 'Animal',
                  user: user
    pin.save! 
    comment = Comment.new body: 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. Magnam adipisci aperiam eum maxime quam sed, in vero quasi laboriosam cumque? Iure odit debitis consectetur maxime recusandae culpa perferendis vitae id? Lorem ipsum dolor, sit amet consectetur adipisicing elit. Magnam adipisci aperiam eum maxime quam sed, in vero quasi laboriosam cumque? Iure odit debitis consectetur maxime recusandae culpa perferendis vitae id? Lorem ipsum dolor, sit amet consectetur adipisicing elit. Magnam adipisci aperiam eum maxime quam sed, in vero quasi laboriosam cumque? Iure odit debitis consectetur maxime recusandae culpa perferendis vitae id?',
                          pin: pin, 
                          user: user
    refute comment.valid?
  end

  test 'changing the associated Pin for a Comment' do
    user = User.new email: 'dummy@email.com'
    pin_1 = Pin.new title: 'Cat funny image',
                  image_url: 'image/url',
                  tag: 'Animal',
                  user: user
    pin_1.save!
    comment = Comment.new body: "It is so cute!", 
                          pin: pin_1, 
                          user: user
    comment.save!
    pin_2 = Pin.new title: 'Dog image',
                    image_url: 'image/url',
                    tag: 'Animal Funny',
                    user: user
    pin_2.save!
    comment.pin = pin_2
    comment.save!
    assert_equal Comment.first.pin, pin_2
  end

  test 'cascading save' do
    user = User.new email: 'dummy@email.com'
    pin = Pin.new title: 'Cat funny image',
                  image_url: 'image/url',
                  tag: 'Animal',
                  user: user
    comment = Comment.new body: "It is so cute!", 
                          pin: pin, 
                          user: user
    pin.comments << comment
    pin.save!
    assert_equal Comment.first, comment
  end

  test 'Comments are ordered correctly' do
    user = User.new email: 'dummy@email.com'
    pin = Pin.new title: 'Cat funny image',
                  image_url: 'image/url',
                  tag: 'Animal',
                  user: user
    comment_1 = Comment.new body: "It is so cute!", 
                  pin: pin, 
                  user: user
    comment_2 = Comment.new body: "It is so cute!", 
                  pin: pin, 
                  user: user
    pin.comments << comment_1
    pin.comments << comment_2
    pin.save!
    assert_equal pin.comments.first, comment_1
    assert_equal 2, pin.comments.length
  end

  test 'Invert comment order' do
    user = User.new email: 'dummy@email.com'
    pin = Pin.new title: 'Cat funny image',
                  image_url: 'image/url',
                  tag: 'Animal',
                  user: user
    comment_1 = Comment.new body: "It is so cute!", 
                  pin: pin, 
                  user: user
    comment_2 = Comment.new body: "It is so cute!", 
                  pin: pin, 
                  user: user
    pin.comments << comment_1
    pin.comments << comment_2
    pin.save!
    assert_equal pin.comments_invert.first, comment_2
    assert_equal 2, pin.comments_invert.length
  end
end
