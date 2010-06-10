Given /^I am kelvin and have the following lists:$/ do |table|
  # Create user kelvin from factory
  user = Factory(:user, :username => "kelvin")
  # Create the list from table hash and associate them with user kelvin
  table.hashes.each do |hash|
    hash[:user] = user
    Factory(:list, hash)
  end
end

Then /^I should see only the following lists:$/ do |table|
  table.diff!(tableish('table tr', 'td,th'))
end

