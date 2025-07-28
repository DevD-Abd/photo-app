require "test_helper"

class Admin::PaymentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @payment = payments(:one)
    @admin_user = User.create!(email: "admin@admin.com", password: "password123", confirmed_at: Time.current)
    sign_in @admin_user
  end

  test "should get index" do
    get admin_payments_url
    assert_response :success
  end

  test "should get show" do
    get admin_payment_url(@payment)
    assert_response :success
  end
end
