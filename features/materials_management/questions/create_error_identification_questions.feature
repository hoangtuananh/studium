Feature: Create Error Identification Questions
	In order to create new error identification questions
	As an admin
	I want to be able to create new error identification questions in my material ms page

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
		# Given I follow "Add Question"

	################## Error Identification questions #################
	@javascript
	Scenario: Create error identification questions with valid attributes
		When I select "Writing (Multiple Choice)" from "Category"
		And I select "Error Identification" from "Question Type"
		And I press "Proceed"
		When I fill in "Question Title" with "Testing EI Question"
		And I fill in "Question Prompt" with "Something <un>about</un> the project <un>must have</un> energized the bureaucrats; only six months <un>after</un> plans <un>are submitted</un>, the playground was complete." 
		And I fill in "Content # 1" with "about"
		And I fill in "Content # 2" with "must have"
		And I fill in "Content # 3" with "after"
		And I fill in "Content # 4" with "are submitted"
		And I fill in "Content # 5" with "No Error"
		# And I fill in "Experience" with "100"
		And I press "Create Question"
		And I should see "Question has been created."
		# And I should see "Testing EI Question"
		# And I should see "Something about the project must have..."
		
	@javascript
	Scenario: Create Error Identification questions with invalid attributes
		When I select "Writing (Multiple Choice)" from "Category"
		And I select "Error Identification" from "Question Type"
		And I press "Proceed"
		And I press "Create Question"
		Then I should see "Invalid Question Information. Question has not been created."
		And I should see "Prompt can't be blank"
		# And I should see "Choice A can't be blank"
		# And I should see "Choice B can't be blank"
		# And I should see "Choice C can't be blank"
		# And I should see "Choice D can't be blank"
		# And I should see "Choice E can't be blank"
		# And I should see "Experience can't be blank"
		# And I should see "You haven't selected the correct choice"
