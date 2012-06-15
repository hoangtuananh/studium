Feature: Create Sentence Improvement Questions
	In order to create new sentence improvement questions
	As an admin
	I want to be able to create new sentence improvement questions in my material ms page

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

	################## Sentence Improvement questions #################
	@javascript
	Scenario: Create sentence improvement questions with valid attributes
		When I select "Writing (Multiple Choice)" from "Category"
		And I select "Sentence Improvement" from "Question Type"
		And I press "Proceed"
		When I fill in "Question Title" with "Testing SI Question"
		And I fill in "Question Prompt" with "Research has shown that <ul 0>chilren, born with the ability to learn</ul 0> any human language, even several laguages at the same time." 
		And I fill in "Content # 1" with "children, born with the ability to learn"
		And I fill in "Content # 2" with "chilren, when born with the ability for learning"
		And I fill in "Content # 3" with "children, they are born with the ability to learn"
		And I fill in "Content # 4" with "children born with the ability to be learning"
		And I fill in "Content # 5" with "children are born with the ability to learn"
		And I check "#5 Correct?"
		# And I fill in "Experience" with "100"
		And I press "Create Question"
		Then I should see "Question has been created."
		And I should see "Testing SI Question"
		And I should see "Research has shown that"
		
	@javascript
	Scenario: Create Sentence Improvement questions with invalid attributes
		When I select "Writing (Multiple Choice)" from "Category"
		And I select "Sentence Improvement" from "Question Type"
		And I press "Proceed"
		And I press "Create Question"
		Then I should see "Invalid Question Information. Question has not been created."
		And I should see "Question prompt can't be blank"
		# And I should see "Choice A can't be blank"
		# And I should see "Choice B can't be blank"
		# And I should see "Choice C can't be blank"
		# And I should see "Choice D can't be blank"
		# And I should see "Choice E can't be blank"
		# And I should see "Experience can't be blank"
		And I should see "You haven't selected the correct choice"
