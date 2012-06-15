Given /^the following questions exist:$/ do |table|
  table.hashes.each do |attr|
    Question.create! attr
  end
end
