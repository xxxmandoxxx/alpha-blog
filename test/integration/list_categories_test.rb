require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest
   
   def setup
      @category = Category.create(name: "sports")
      @category2 = Category.create(name: "news")
   end
   
   test "should show category listing" do
       get categories_path
       assert_template 'categories/index'
       assert_select "a[href=?]", category_path(@category), text: @category.name.capitalize
       assert_select "a[href=?]", category_path(@category2), text: @category2.name.capitalize
   end
    
end