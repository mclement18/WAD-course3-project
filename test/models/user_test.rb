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
end
