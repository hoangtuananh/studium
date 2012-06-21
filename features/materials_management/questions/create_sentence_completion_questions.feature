Feature: Create Sentence Completion Questions
	In order to create new sentence completion questions
	As an admin
	I want to be able to create new sc questions in my material ms page

	Background:
		Given the following users exist:
			| email							 | password | admin |
			| admin@ticketee.com | password | true  |
		And I am signed in as "admin@ticketee.com" with password "password"
		And I have run the seed task
		And I am on the home page
		When I follow "Admin Page"
		And I follow "Materials"
		And I follow "Questions"
		And I follow "Add Question"

	################## Sentence Completion questions ###################
	@javascript
	Scenario: Create sentence completion questions with valid attributes
		When I select "Critical Reading" from "Category"
		And I select "Sentence Completion" from "Question Type"
		And I press "Proceed"
		When I fill in "Question Title" with "Testing SC Question"
		And I fill in "Question Prompt" with "There had been a <bl /> improvement as a result of John's lessons, even though individual questions did not seem to improve his studies." 
		And I fill in "Content # 1" with "cumulative"
		And I fill in "Content # 2" with "digressive"
		And I fill in "Content # 3" with "restive"
		And I fill in "Content # 4" with "superlative"
		And I fill in "Content # 5" with "innovative"
		And I check "#1 Correct?"
		# And I fill in "Experience" with "100"
		And I press "Create Question"
		And I should see "Question has been created."
		And I should see "Testing SC Question"
		And I should see "There had been a"
		
	@javascript
	Scenario: Create setence completion questions with no choice filled
		When I select "Critical Reading" from "Category"
		And I select "Sentence Completion" from "Question Type"
		And I press "Proceed"
		And I press "Create Question"
		Then I should see "Invalid Question Information. Question has not been created."
		And I should see "Question Prompt can't be blank"
		And I should see "Question must have at least one choice"

	@javascript
	Scenario: Create setence completion questions with no correct choice
		When I select "Critical Reading" from "Category"
		And I select "Sentence Completion" from "Question Type"
		And I press "Proceed"
		And I fill in "Content # 1" with "cumulative"
		And I fill in "Content # 2" with "digressive"
		And I fill in "Content # 3" with "restive"
		And I fill in "Content # 4" with "superlative"
		And I fill in "Content # 5" with "innovative"
		And I press "Create Question"
		Then I should see "Invalid Question Information. Question has not been created."
		And I should see "Question Prompt can't be blank"
		And I should see "Question must have at least one correct choice"
