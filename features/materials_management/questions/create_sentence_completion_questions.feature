Feature: Create Questions
	In order to create new questions
	As an admin
	I want to be able to create new questions in my material ms page

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

	################## Sentence Completion questions ###################
	Scenario: Create sentence completion questions with valid attributes
		When I select "Critical Reading" from "Category"
		And I select "Sentence Completion" from "Question Type"
		And I press "Proceed"
		When I fill in "Question Title" with "Testing SC Question"
		And I fill in "Question Prompt" with "There had been a <bl /> improvement as a result of John's lessons, even though individual questions did not seem to improve his studies." 
		And I fill in "A" with "cumulative"
		And I check "question_choice_a_checkbox"
		And I fill in "B" with "digressive"
		And I fill in "C" with "restive"
		And I fill in "D" with "superlative"
		And I fill in "E" with "innovative"
		And I fill in "Experience" with "100"
		And I press "Add Question"
		Then I should be on the index page for materials/questions
		And I should see "Testing SC Question"
		And I should see "There had been a..."
		
	Scenario: Create setence completion questions with invalid attributes
		When I select "Critical Reading" from "Category"
		And I select "Sentence Completion" from "Question Type"
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
