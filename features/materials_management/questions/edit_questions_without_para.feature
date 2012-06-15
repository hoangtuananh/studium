Feature: Edit Questions that have no associated paragraphs
	In order to edit questions that have no associated paragraphs
	As an admin
	I want to be able to edit questions like that in the question index page

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

	@javascript
	Scenario: Edit with valid attributes
		Given I follow "Edit"
		When I fill in "Title" with "Question Olala"
		And I fill in "Prompt" with "I do not want anything from you."
		And I fill in "Content A" with "A is not A"
		And I fill in "Content B" with "B is not B"
		And I fill in "Content C" with "C is not C"
		And I fill in "Content D" with "D is not D"
		And I fill in "Content E" with "E is not E"
		And I select "B"
		And I press "Update"
		Then I should see "Question Olala"
		And I should not see "Test Question"
		And I should see "Question has been updated."
		When I follow "Question Olala"
		Then I should not see "A is A"
		But I should see "A is not A"
		Then I should not see "B is B"
		Then I should not see "B is B"
		But I should see "C is not C"
		But I should see "C is not C"
		Then I should not see "D is D"
		But I should see "D is not D"
		Then I should not see "E is E"
		But I should see "E is not E"	

	@javascript
	Scenario: Edit with invalid attributes
		Given I follow "Edit"
		When I fill in "Title" with ""
		And I fill in "Prompt" with ""
		And I fill in "Content A" with ""
		And I fill in "Content B" with ""
		And I fill in "Content C" with ""
		And I fill in "Content D" with ""
		And I fill in "Content E" with ""
		And I press "Update"
		Then I should see "Question has not been updated. Invalid Information."
		And I should see "Question title can't be blank."
		And I should see "Question prompt can't be blank."
