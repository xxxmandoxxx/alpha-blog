require 'test_helper'

class SignupUserTest <  ActionDispatch::IntegrationTest
   
   test "sign up user process" do
       get signup_path
       assert_template 'users/new'
       assert_difference "User.count", 1 do
          post_via_redirect users_path, user: { username: "John", email:"John@example.com", password: "password" }
       end
       assert_template 'articles/index'
       assert_match "John", response.body
   end
    
end