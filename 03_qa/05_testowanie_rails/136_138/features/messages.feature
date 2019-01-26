Feature: Messages
	Scenario: List messages
		Given I am logged in as a user
		Given I am on "/messages" page
    Then page should have notice "Id"
    Then page should have notice "Content"
    Then page should have notice "Processed at"
    Then page should have notice "Created at"
    Then page should have notice "Updated at"

