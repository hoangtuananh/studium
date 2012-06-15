Feature: Delete Questions
	In order to delete existing questions
	As an admin
	I want to be able to delete questions

	Background:
		Given the following questions exist:
			| title 	 			| prompt		 				 | exp  |
			| Test Question | What do you want? | 1400 |
		And the followng choices exist:
			| choice_letter | content | correct |
			| A							| A is A	| false		|
			| B							| B is B	| false		|
			| C							| C is C	| true		|
			| D							| D is D	| false		|
			| E							| E is E	| false		|
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

	Scenario: Delete Quesitons
		When I follow "Delete"
		Then I should see "Question has been deleted."
		And I should not see "Test Question"
