Feature: Create Reading Questions
	In order to create new reading questions
	As an admin
	I want to be able to create new reading questions in my material ms page

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
		And I select "Critical Reading" from "Category"
		And I select "Reading" from "Question Type"
		And I press "Proceed"

	################ Single Paragraph Reading question ################
	@javascript
	Scenario: Create Single Paragraph Reading questions with valid attributes
		When I fill in "Paragraph Title" with "Manhanden Fish"
		And I fill in "Paragraph Content" with "Your life may very well depend on a fish that few have heard of--the menhaden. No one actually eats the menhaden because they are oily, foul, and packed with bones. But they can be ground up and used as a high protein feed for chicken, pigs, and cattle. (Pop some barbecued wings in your mouth and part of what you're eating was once menhaden.) Furthermore, menhaden are filter feeders that help the control of algae devastating to coastal fisheries. Marine biologist Sarah Gottlieb says, 'Think of the menhaden as the liver of a bay. Just as your body needs its liver to filter out toxins, ecosystems also need those natural filters.'"
		And I fill in "Question # 2 Title" with "Test Question Title"
		And I fill in "Question # 2 Prompt" with "Test Question Prompt"
		And I fill in "Content # 2.1" with "A is A"
		And I fill in "Content # 2.2" with "B is B"
		And I fill in "Content # 2.3" with "C is C"
		And I fill in "Content # 2.4" with "D is D"
		And I fill in "Content # 2.5" with "E is E"
		And I check "# 2.1 Correct?"
		And I press "Create Paragraph"
		Then I should see "Question has been created"
		And I should see "Test Question"
		When I follow "Test Question"
		Then I should see "Manhanden Fish"
		And I should see "Your life may very well depend on a fish that few have heard of"
		And I should see "Test Question Title"
		And I should see "Test Question Prompt"
		And I should see "A is A"
		And I should see "B is B"
		And I should see "C is C"
		And I should see "D is D"
		And I should see "E is E"

	@javascript
	Scenario: Create Reading questions with invalid attributes
		When I press "Create Paragraph"
		Then I should see "Invalid Question Information. Question has not been created."
		And I should see "Title can't be blank"
		And I should see "Content can't be blank"
    And I should see "Paragraph must have at least one question"
