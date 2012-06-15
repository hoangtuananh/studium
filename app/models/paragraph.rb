class Paragraph < ActiveRecord::Base
  has_many :questions
  accepts_nested_attributes_for :questions, :reject_if => lambda { |q| q[:title].blank?}
end
