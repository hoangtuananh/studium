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

Given /^the following paragraphs exist:$/ do |table|
  table.hashes.each do |attr|
    step %Q[I am signed in as "admin@ticketee.com" with password "password"]
    step %Q[I am on the home page]
    step %Q[I follow "Admin Page"]
    step %Q[I follow "Materials"]
    step %Q[I follow "Questions"]
    step %Q[I follow "Add Question"]
		step %Q[I fill in "Paragraph Title" with "Manhanden Fish"]
		step %Q[I fill in "Paragraph Content" with "Your life may very well depend on a fish that few have heard of--the menhaden. No one actually eats the menhaden because they are oily, foul, and packed with bones. But they can be ground up and used as a high protein feed for chicken, pigs, and cattle. (Pop some barbecued wings in your mouth and part of what you're eating was once menhaden.) Furthermore, menhaden are filter feeders that help the control of algae devastating to coastal fisheries. Marine biologist Sarah Gottlieb says, \"Think of the menhaden as the liver of a bay. Just as your body needs its liver to filter out toxins, ecosystems also need those natural filters.\""]
  end
end
