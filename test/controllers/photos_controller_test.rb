require "test_helper"

class PhotosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
    @photo = photos(:one)
  end

  test "should get index" do
    get photos_url
    assert_response :success
  end

  test "should get show" do
    get photo_url(@photo)
    assert_response :success
  end

  test "should get new" do
    get new_photo_url
    assert_response :success
  end

  test "should show create form" do
    get new_photo_url
    assert_response :success
    assert_select "form"
  end

  test "should get edit" do
    get edit_photo_url(@photo)
    assert_response :success
  end

  test "should show edit form" do
    get edit_photo_url(@photo)
    assert_response :success
    assert_select "form"
  end

  test "should destroy photo" do
    assert_difference("Photo.count", -1) do
      delete photo_url(@photo)
    end
    assert_redirected_to photos_url
  end
end
