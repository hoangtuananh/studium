Feature: Remove Choices From Existing Questions
	In order to remove choices from existing questions
	As an admin
	I want to be able to remove choices from existing questions

	Background:
		Given the following users exist:
			| email							 | password | admin |
			| admin@ticketee.com | password | true  |
		And I am signed in as "admin@ticketee.com" with password "password"
		And I have run the seed task

	@javascript
	Scenario: Edit with valid attributes
		Given a question with paragraph for testing purpose exists
		And I am on the home page
		Given I follow "Admin Page"
		And I follow "Materials"
		And I follow "Questions"
		And I follow "Test Question"
		And I follow "Edit"
		When I fill in "Question Title" with "Question Olala"
		And I fill in "Question Prompt" with "I do not want anything from you."
		And I fill in "Content # 1" with "A is not A"
		And I fill in "Content # 2" with "B is not B"
		And I fill in "Content # 3" with "C is not C"
		And I fill in "Content # 4" with "D is not D"
		And I follow "Remove # 5"
		And I check "#2 Correct?"
		And I uncheck "#1 Correct?"
		And I fill in "Paragraph Title" with "What the hell?"
		And I fill in "Paragraph Content" with "What the heck?" 
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
		And I should see "What the hell?"
		But I should not see "Manhanden Fish"
		And I should see "What the heck?"
		But I should not see "Your life may very well"

	@javascript
	Scenario: Edit with valid attributes
		Given a question without paragraph for testing purpose exists
		And I am on the home page
		Given I follow "Admin Page"
		And I follow "Materials"
		And I follow "Questions"
		And I follow "Test Question"
		And I follow "Edit"
		When I fill in "Question Title" with "Question Olala"
		And I fill in "Question Prompt" with "I do not want anything from you."
		And I fill in "Content # 1" with "A is not A"
		And I fill in "Content # 2" with "B is not B"
		And I fill in "Content # 3" with "C is not C"
		And I fill in "Content # 4" with "D is not D"
		And I follow "Remove # 5"
		And I check "#2 Correct?"
		And I uncheck "#1 Correct?"
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
