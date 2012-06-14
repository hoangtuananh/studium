class CategoryType < ActiveRecord::Base
  has_many :question_types
end
