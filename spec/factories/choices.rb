# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :choice do
    choice_letter "A"
    content "Test Choice"
    correct false
  end
end
