require "application_system_test_case"

class PoliciesTest < ApplicationSystemTestCase
  setup do
    @policy = policies(:one)
  end

  test "visiting the index" do
    visit policies_url
    assert_selector "h1", text: "Policies"
  end

  test "should create policy" do
    visit policies_url
    click_on "New policy"

    click_on "Create Policy"

    assert_text "Policy was successfully created"
    click_on "Back"
  end

  test "should update Policy" do
    visit policy_url(@policy)
    click_on "Edit this policy", match: :first

    click_on "Update Policy"

    assert_text "Policy was successfully updated"
    click_on "Back"
  end

  test "should destroy Policy" do
    visit policy_url(@policy)
    click_on "Destroy this policy", match: :first

    assert_text "Policy was successfully destroyed"
  end
end
