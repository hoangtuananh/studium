Feature: Edit User Profile
	In order to edit my profile info
	As a user
	I want to be able to edit my profile info

	Background:
		Given the following users exist:
			| email							| password |
			| user@ticketee.com | password |
		And user "user@ticketee.com" has the following profile info:
			| first_name | last_name | school 					 |
			| Kien			 | Hoang		 | Lafayette College |
		And I am signed in as "user@ticketee.com" with password "password"
		And I follow "user@ticketee.com"

	Scenario: Update Profile with Valid Info
		When I fill in "First name" with "Chau"
		And I fill in "Last name" with "Tran"
		And I fill in "School" with "Brown University"
		And I follow "Update Profile"
		Then I should be on the profile page for "user@ticketee.com"
		And I should see "Profile has been updated."
		And I should not see "Kien Hoang"
		And I should not see "Lafayette College"
		But I should see "Chau Tran"
		And I should see "Brown University"

	Scenario: Update Profile with invalid Info
		When I fill in "First name" with ""
		And I fill in "Last name" with ""
		And I fill in "School" with ""
		And I follow "Update Profile"
		Then I should see "Profile has not been updated."
		And I should see "First name" can't be blank
		And I should see "Last name" can't be blank
		And I should see "School" can't be blank
