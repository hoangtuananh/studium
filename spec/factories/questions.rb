# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    title "Testing"
    prompt "For Testing Purpose Only"
    exp 1400
    question_type_id 1  
  end
end
