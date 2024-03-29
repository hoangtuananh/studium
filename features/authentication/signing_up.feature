Feature: Signing up
	In order to sign up for an account in Studium
	As a guest
	I want to be able to sign up

	Scenario:
		Given I am on the home page
		When I follow "Sign up"
		And I fill in "Email" with "user@ticketee.com"
		And I fill in "Password" with "password"
		And I fill in "Password confirmation" with "password"
		And I fill in "First name" with "Ticketee"
		And I fill in "Last name" with "User"
		And I fill in "School" with "Ticketee"
		And I press "Sign up"
		Then I should be on the dashboard page
		And I should see "user@ticketee.com"
		And I should see "Sign out"
		And I should not see "Sign up"
		And I should not see "Sign in"
