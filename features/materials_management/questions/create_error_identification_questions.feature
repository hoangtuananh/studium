Feature: Create Questions
	In order to create new error identification questions
	As an admin
	I want to be able to create new error identification questions in my material ms page

	Background:
		Given the following users exist:
			| email							 | password | admin |
			| admin@ticketee.com | password | true  |
		And I am signed in as "admin@ticktee.com" with password "password"
		And I am on the home page
		When I follow "Admin Page"
		And I follow "Material Management Page"
		And I follow "Questions"
		Then I should be on the index page for materials/questions
		Given I follow "Add Question"

	################## Error Identification questions #################
	Scenario: Create error identification questions with valid attributes
		When I select "Writing (Multiple Choice)" from "Category"
		And I select "Error Identification" from "Question Type"
		And I press "Proceed"
		When I fill in "Question Title" with "Testing EI Question"
		And I fill in "Question Prompt" with "Something <un>about</un> the project <un>must have</un> energized the bureaucrats; only six months <un>after</un> plans <un>are submitted</un>, the playground was complete." 
		And I fill in "A" with "about"
		And I fill in "B" with "must have"
		And I fill in "C" with "after"
		And I fill in "D" with "are submitted"
		And I fill in "E" with "No Error"
		And I check "question_choice_d_checkbox"
		And I fill in "Experience" with "100"
		And I press "Add Question"
		Then I should be on the index page for materials/questions
		And I should see "Testing EI Question"
		And I should see "Something about the project must have..."
		
	Scenario: Create Error Identification questions with invalid attributes
		When I select "Writing (Multiple Choice)" from "Category"
		And I select "Error Identification" from "Question Type"
		And I press "Proceed"
		When I fill in "Question Title" with ""
		And I fill in "Question Prompt" with "" 
		And I fill in "A" with ""
		And I fill in "B" with ""
		And I fill in "C" with ""
		And I fill in "D" with ""
		And I fill in "E" with ""
		And I fill in "Experience" with ""
		And I press "Add Question"
		Then I should see "Invalid Question Information. Question has not been created."
		And I should see "Prompt can't be blank"
		And I should see "Choice A can't be blank"
		And I should see "Choice B can't be blank"
		And I should see "Choice C can't be blank"
		And I should see "Choice D can't be blank"
		And I should see "Choice E can't be blank"
		And I should see "Experience can't be blank"
		And I should see "You haven't selected the correct choice"
