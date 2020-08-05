require 'test_helper'


class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    admin = User.create(first_name: 'joe',
                        last_name: 'admin',
                        is_admin: true,
                        email: 'joe@example.com',
                        password: 'password!!',
                        password_confirmation: 'password!!')
    sign_in admin
  end

  test 'should get index' do
    get users_url
    assert_response :success
  end

  test 'should get new' do
    get new_user_url
    assert_response :success
  end


  test 'should show user' do
    get user_url(@user)
    assert_response :success
  end

  test 'should get edit' do
    get edit_user_url(@user)
    assert_response :success
  end


  test 'should destroy user' do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
