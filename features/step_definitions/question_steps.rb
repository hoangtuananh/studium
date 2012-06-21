When /^I confirm popup$/ do
  page.driver.browser.switch_to.alert.accept
end
Given /^the questions with the following titles exist:$/ do |table|
  table.hashes.each do |attr|
    @question=FactoryGirl.build :question,title: attr[:title]
    @question.save(validate: false)
  end
end

Given /^the following choices exist:$/ do |table|
  table.hashes.each do |attr|
    FactoryGirl.create :choice,attr.merge!(question_id: @question.id)
  end
end

Given /^a question with paragraph for testing purpose exists$/ do
  step %Q[I am on the home page]
  step %Q[I follow "Admin Page"]
  step %Q[I follow "Materials"]
  step %Q[I follow "Questions"]
  step %Q[I follow "Add Question"]
  step %Q[I select "Critical Reading" from "Category"]
  step %Q[I select "Reading" from "Question Type"]
  step %Q[I press "Proceed"]
  step %Q[I fill in "Paragraph Title" with "Manhanden Fish"]
  step %Q[I fill in "Paragraph Content" with "Your life may very well depend on a fish that few have heard of--the menhaden. No one actually eats the menhaden because they are oily, foul, and packed with bones. But they can be ground up and used as a high protein feed for chicken, pigs, and cattle. (Pop some barbecued wings in your mouth and part of what you're eating was once menhaden.) Furthermore, menhaden are filter feeders that help the control of algae devastating to coastal fisheries. Marine biologist Sarah Gottlieb says, 'Think of the menhaden as the liver of a bay. Just as your body needs its liver to filter out toxins, ecosystems also need those natural filters.'"]
  step %Q[I fill in "Question # 1 Title" with "Test Question"]
  step %Q[I fill in "Question # 1 Prompt" with "Test Question Prompt"]
  step %Q[I fill in "Content # 1.1" with "A is A"]
  step %Q[I fill in "Content # 1.2" with "B is B"]
  step %Q[I fill in "Content # 1.3" with "C is C"]
  step %Q[I fill in "Content # 1.4" with "D is D"]
  step %Q[I fill in "Content # 1.5" with "E is E"]
  step %Q[I check "# 1.1 Correct?"]
  step %Q[I press "Create Paragraph"]
end

Given /^a question without paragraph for testing purpose exists$/ do
  step %Q[I am on the home page]
  step %Q[I follow "Admin Page"]
  step %Q[I follow "Materials"]
  step %Q[I follow "Questions"]
  step %Q[I follow "Add Question"]
  step %Q[I select "Critical Reading" from "Category"]
  step %Q[I select "Sentence Completion" from "Question Type"]
  step %Q[I press "Proceed"]
  step %Q[I fill in "Question Title" with "Test Question"]
  step %Q[I fill in "Question Prompt" with "Test Question Prompt"]
  step %Q[I fill in "Content # 1" with "A is A"]
  step %Q[I fill in "Content # 2" with "B is B"]
  step %Q[I fill in "Content # 3" with "C is C"]
  step %Q[I fill in "Content # 4" with "D is D"]
  step %Q[I fill in "Content # 5" with "E is E"]
  step %Q[I check "#1 Correct?"]
  step %Q[I press "Create Question"]
end
