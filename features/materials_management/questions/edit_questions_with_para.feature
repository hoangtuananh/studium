Feature: Edit Questions that have associated paragraphs
	In order to edit questions that have associated paragraphs
	As an admin
	I want to be able to edit questions like that in the question index page

	Background:
		Given a paragraph for testing purpose exists
		And the following users exist:
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
		And I fill in "Content # 1" with "A is not A"
		And I fill in "Content # 2" with "B is not B"
		And I fill in "Content # 3" with "C is not C"
		And I fill in "Content # 4" with "D is not D"
		And I fill in "Content # 5" with "E is not E"
		And I check "#2 Correct?"
		And I uncheck "#1 Correct?"
		And I fill in "Paragraph title" with "What the hell?"
		And I fill in "Paragraph content" with "What the heck?" 
		And I press "Update Question"
		Then I should see "Question has been updated."
		And I should see "Question Olala"
		And I should not see "Test Question"
		And I should see "Question has been updated."
		And I should not see "A is A"
		But I should see "A is not A"
		And I should not see "B is B"
		But I should see "B is not B"
		And I should not see "C is C"
		But I should see "C is not C"
		And I should not see "D is D"
		But I should see "D is not D"
		And I should not see "E is E"
		But I should see "E is not E"	
		And I should see "What the hell?"
		But I should not see "Manhanden Fish"
		And I should see "What the heck?"
		But I should not see "Your life may very well"

	@javascript
	Scenario: Edit with invalid attributes
		Given I follow "Edit"
		When I fill in "Question Title" with ""
		And I fill in "Question Prompt" with ""
		And I fill in "Content # 1" with ""
		And I fill in "Content # 2" with ""
		And I fill in "Content # 3" with ""
		And I fill in "Content # 4" with ""
		And I fill in "Content # 5" with ""
		And I uncheck "#3 Correct?"
		And I press "Update Question"
		Then I should see "Question title can't be blank"
		And I should see "Question prompt can't be blank"
