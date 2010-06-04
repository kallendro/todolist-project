Factory.define :user do |f|
  f.firstname "John"
  f.lastname "Woo"
  f.username "johnwoo"
  f.password "password"
  f.dob "1-1-1999"
end

Factory.define :list do |f|
  f.subject "hallo"
  f.user {|a| a.association(:user) }
end

Factory.define :todo do |f|
  f.subject "mytodo"
  f.list {|a| a.association(:list) }
end
