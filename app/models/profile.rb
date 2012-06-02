class Profile < ActiveRecord::Base
  belongs_to :user

  validates :first_name,:last_name,:school,presence: true
end
