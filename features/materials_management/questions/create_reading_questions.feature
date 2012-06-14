Feature: Create Reading Questions
	In order to create new reading questions
	As an admin
	I want to be able to create new reading questions in my material ms page

	Background:
		Given the following users exist:
			| email							 | password | admin |
			| admin@ticketee.com | password | true  |
		And I am signed in as "admin@ticketee.com" with password "password"
		And I am on the home page
		And I have run the seed task
		When I follow "Admin Page"
		And I follow "Materials"
		And I follow "Questions"

	################ Single Paragraph Reading question ################
	@javascript
	Scenario: Create Single Paragraph Reading questions with valid attributes
		When I select "Critical Reading" from "Category"
		And I select "Reading" from "Question Type"
		And I press "Proceed"
		When I fill in "Question Title" with "Testing Reading Question"
		And I fill in "Question Prompt" with "The primary purpose of the passage is to" 
		And I press "Add Paragraph"
		And I fill in "Paragraph Title" with "Manhanden Fish"
		And I fill in "Paragraph Content" with "Your life may very well depend on a fish that few have heard of--the menhaden. No one actually eats the menhaden because they are oily, foul, and packed with bones. But they can be ground up and used as a high protein feed for chicken, pigs, and cattle. (Pop some barbecued wings in your mouth and part of what you're eating was once menhaden.) Furthermore, menhaden are filter feeders that help the control of algae devastating to coastal fisheries. Marine biologist Sarah Gottlieb says, \"Think of the menhaden as the liver of a bay. Just as your body needs its liver to filter out toxins, ecosystems also need those natural filters.\""
		And I press "Create Paragraph"
		And I fill in "A" with "offer a hypothesis about the origins of a food staple"
		And I fill in "B" with "describe the main habitat of a certain species of fish"
		And I fill in "C" with "note the steady rise of costal waters"
		And I fill in "D" with "convey the importance of a particular species of fish"
		And I fill in "E" with "discuss the overharvesting of fish species in coastal waters"
		And I check "question_choice_d_checkbox"
		And I fill in "Experience" with "100"
		And I press "Add Question"
		Then I should be on the index page for materials/questions
		And I should see "Testing Reading Question"
		And I should see "The primary purpose of the passage..."

	################ Double Paragraph Reading question ################
	@javascript
	Scenario: Create Double Paragraph Reading questions with valid attributes
		When I select "Critical Reading" from "Category"
		And I select "Reading" from "Question Type"
		And I press "Proceed"
		When I fill in "Question Title" with "Testing Reading Question"
		And I fill in "Question Prompt" with "The primary purpose of the passage is to" 
		And I press "Add Paragraph"
		And I fill in "Paragraph Title" with "Manhanden Fish"
		And I fill in "Paragraph Content" with "Your life may very well depend on a fish that few have heard of--the menhaden. No one actually eats the menhaden because they are oily, foul, and packed with bones. But they can be ground up and used as a high protein feed for chicken, pigs, and cattle. (Pop some barbecued wings in your mouth and part of what you're eating was once menhaden.) Furthermore, menhaden are filter feeders that help the control of algae devastating to coastal fisheries. Marine biologist Sarah Gottlieb says, \"Think of the menhaden as the liver of a bay. Just as your body needs its liver to filter out toxins, ecosystems also need those natural filters.\""
		And I press "Create Paragraph"
		And I press "Add Paragraph"
		And I fill in "Paragraph Title" with "Black Artists"
		And I fill in "Paragraph Content" with "For Blank artists working early in the twentieth century, the question of how best to gain support for their work was a compelling one. Some of them argued that they should incorporate their African heritage into their art production and choose themes representing the share experiences of Black people."
		And I press "Create Paragraph"
		And I fill in "A" with "offer a hypothesis about the origins of a food staple"
		And I fill in "B" with "describe the main habitat of a certain species of fish"
		And I fill in "C" with "note the steady rise of costal waters"
		And I fill in "D" with "convey the importance of a particular species of fish"
		And I fill in "E" with "discuss the overharvesting of fish species in coastal waters"
		And I check "question_choice_d_checkbox"
		And I fill in "Experience" with "100"
		And I press "Add Question"
		Then I should be on the index page for materials/questions
		And I should see "Question has been created."
		And I should see "Testing Reading Question"
		And I should see "The primary purpose of the passage..."

	############# Reading questioni with existing paragragh ###########
	@javascript
	Scenario: Create Single Paragraph Reading questions and add an existing paragraph to it
		Given the following paragraphs exist:
			| title 					| content 														|
			| Manhanden Fish 	| Testing Paragraph Testing Paragraph | 
		When I select "Critical Reading" from "Category"
		And I select "Reading" from "Question Type"
		And I press "Proceed"
		When I fill in "Question Title" with "Testing Reading Question"
		And # I fill in "Question Prompt" with "The primary purpose of the passage is to" 
		And I press "Choose Existing"
		And I fill in "Paragraph Title" with "Manhanden Fish"
		And I press "Add"
		Then I should see "Testing Paragraph Testing Paragraph"
		When I fill in "A" with "offer a hypothesis about the origins of a food staple"
		And I fill in "B" with "describe the main habitat of a certain species of fish"
		And I fill in "C" with "note the steady rise of costal waters"
		And I fill in "D" with "convey the importance of a particular species of fish"
		And I fill in "E" with "discuss the overharvesting of fish species in coastal waters"
		And I check "question_choice_d_checkbox"
		And I fill in "Experience" with "100"
		And I press "Add Question"
		Then I should be on the index page for materials/questions
		And I should see "Question has been created."
		And I should see "Testing Reading Question"
		And I should see "The primary purpose of the passage..."
		
	@javascript
	Scenario: Create Reading questions with invalid attributes
		When I select "Writing (Multiple Choice)" from "Category"
		And I select "reading" from "Question Type"
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
		And I should see "Question must have at least one paragraph"
		And I should see "Choice A can't be blank"
		And I should see "Choice B can't be blank"
		And I should see "Choice C can't be blank"
		And I should see "Choice D can't be blank"
		And I should see "Choice E can't be blank"
		And I should see "Experience can't be blank"
		And I should see "You haven't selected the correct choice"
