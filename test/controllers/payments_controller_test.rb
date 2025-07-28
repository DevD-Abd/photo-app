require "test_helper"

class PaymentsControllerTest < ActionDispatch::IntegrationTest
  test "should redirect to registration when accessing payment without plan" do
    get new_payment_url
    assert_response :redirect
    assert_redirected_to new_user_registration_url
  end

  test "should get new payment page with valid plan" do
    get new_payment_url, params: { plan: "premium" }
    assert_response :success
  end
end
