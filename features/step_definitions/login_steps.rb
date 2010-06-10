When /^I login as (.+)$/ do |name|
  user = User.find_by_username(name)
  And %\I go to login page\
  And %\I fill in "username" with "#{user.username}"\
  And %\I fill in "password" with "#{user.password}"\
  And %\I press "Login"\
end

Given /^I am not logged in$/ do
  session = nil
end

Then /^I should be redirected to login page$/ do
  And %\I should see "Login"\
  And %\I should see "Username"\
  And %\I should see "Password"\
end

