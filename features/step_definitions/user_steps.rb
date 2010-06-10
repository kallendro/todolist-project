Given /^I have users:$/ do |table|
  table.hashes.each do |hash|
    Factory(:user, hash)
  end
end

Then /^I should see users:$/ do |table|
  table.diff!(tableish('table tr', 'td,th'))
end

