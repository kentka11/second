require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "invalid signup information" do
  	get signup_path
	  assert_no_difference 'User.count' do
  		post users_path, params: { user: { name: "",
  			                                 email: "user@invalid",
  			                                 password: "foo",
  		  	                               password_confirmation: "bar" }}
  	end
  	assert_template 'users/new'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: "Example User",
                                         email: "user@example.com",
                                         password: "password",
                                         password_confirmation: "password"}}
    end
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end

  test "login with valid information followed by logout" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'password' }}
    assert is logged_in?
    delete logout_path
    assert_not is_logged_in
    assert_redirected_to root_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user), count: 0
  end
end
