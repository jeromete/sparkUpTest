require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should not save user without first_name' do
    user = User.new
    user.last_name = 'man'
    user.email = 'super@man.com'
    assert_not user.save, 'saved user without first_name'
  end

  test 'should not save user without last_name' do
    user = User.new
    user.first_name = 'super'
    user.email = 'super@man.com'
    assert_not user.save, 'saved user without last_name'
  end

  test 'should not save user without email' do
    user = User.new
    user.first_name = 'super'
    user.last_name = 'man'
    assert_not user.save, 'saved user without email'
  end

  test 'should save user' do
    user = User.new
    user.first_name = 'super'
    user.last_name = 'man'
    user.email = 'super@man.com'
    assert user.save, 'saved user'
  end
end
