require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get root' do
    get root_url
    assert_response :success
    assert_select 'title', 'Todoアプリ'
  end

  test 'should get help' do
    get help_path
    assert_response :success
    assert_select 'title', 'Help|Todoアプリ'
  end

  test 'should get about' do
    get about_path
    assert_response :success
    assert_select 'title', 'About|Todoアプリ'
  end

  test 'should get contact' do
    get contact_path
    assert_response :success
    assert_select 'title', 'Contact|Todoアプリ'
  end
end
