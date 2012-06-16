Given /^the questions with the following titles exist:$/ do |table|
  table.hashes.each do |attr|
    @question=FactoryGirl.build :question,title: attr[:title]
    @question.save(validate: false)
  end
end
