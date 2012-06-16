Feature: Filter for Index Page
	In order to filter the questions showed on the index page
	As an admin
	I want to filter the questions I see listed on the index page
	
	Background:
		Given 15 questions
		Given the following users exist:
			| email							 | password | admin |
			| admin@ticketee.com | password | true  |
		And I am signed in as "admin@ticketee.com" with password "password"
		And I have run the seed task
		And I am on the home page
		When I follow "Admin Page"
		And I follow "Materials"
		And I follow "Questions"

	Scenario: Select All for the filter
		When I select "All" from Question Category
		And I press "Update Results"
		Then I should see 
