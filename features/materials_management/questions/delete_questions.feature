Feature: Delete Questions
	In order to delete existing questions
	As an admin
	I want to be able to delete questions

	Background:
		Given the questions with the following titles exist:
			| title 	 			|
			| Test Question |
		Given the following users exist:
			| email							 | password | admin |
			| admin@ticketee.com | password | true  |
		And I am signed in as "admin@ticketee.com" with password "password"
		And I have run the seed task
		And I am on the home page
		When I follow "Admin Page"
		And I follow "Materials"
		And I follow "Questions"
		And I follow "Test Question"

	@javascript
	Scenario: Delete Quesitons
		When I follow "Delete"
		Then I should not see "Test Question"
