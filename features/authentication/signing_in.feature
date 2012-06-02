Feature: Signing in
	In order to sign in as a user
	As a guest
	I want to be able to sign in and get redirected to my dashboard

	Background:
		Given the following users exist:
			| email 						| password |
			| user@ticketee.com | password |
		And I am on the home page

	Scenario:
		When I follow "Sign in"
		And I fill in "Email" with "user@ticketee.com"
		And I fill in "Password" with "password"
		And I press "Sign in"
		Then I should be on the dashboard page
		And I should see "user@ticketee.com"
		And I should see "Sign out"
		And I should not see "Sign up"
		And I should not see "Sign in"
