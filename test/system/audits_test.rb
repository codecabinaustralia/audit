require "application_system_test_case"

class AuditsTest < ApplicationSystemTestCase
  setup do
    @audit = audits(:one)
  end

  test "visiting the index" do
    visit audits_url
    assert_selector "h1", text: "Audits"
  end

  test "creating a Audit" do
    visit audits_url
    click_on "New Audit"

    fill_in "Department", with: @audit.department
    fill_in "Description", with: @audit.description
    fill_in "Title", with: @audit.title
    fill_in "User", with: @audit.user_id
    click_on "Create Audit"

    assert_text "Audit was successfully created"
    click_on "Back"
  end

  test "updating a Audit" do
    visit audits_url
    click_on "Edit", match: :first

    fill_in "Department", with: @audit.department
    fill_in "Description", with: @audit.description
    fill_in "Title", with: @audit.title
    fill_in "User", with: @audit.user_id
    click_on "Update Audit"

    assert_text "Audit was successfully updated"
    click_on "Back"
  end

  test "destroying a Audit" do
    visit audits_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Audit was successfully destroyed"
  end
end
