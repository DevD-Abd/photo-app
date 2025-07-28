require "test_helper"

class PaymentsControllerTest < ActionDispatch::IntegrationTest
  test "should redirect to root when accessing payment without valid plan" do
    get new_payment_url
    assert_response :redirect
    assert_redirected_to root_url
  end

  test "should redirect to registration with valid plan" do
    get new_payment_url, params: { plan: "premium" }
    assert_response :redirect
    assert_redirected_to new_user_registration_url(plan: "premium")
  end
end
