
Given /the following stores exist/ do |stores_table|
  stores_table.hashes.each do |store|
    Store.create store
  end
end

Then (/^(\d+) seed stores should exist$/) do | n_seeds |
  Store.count.should be n_seeds.to_i
end

Then /^the rating of "([^"]*)" should be "([^"]*)"$/ do |arg1, arg2|
  expect(Store.find_by_name(arg1).rating).to eq(arg2)
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body.index(e1) < page.body.index(e2))
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(', ').each do |rating|
    step %{I #{uncheck.nil? ? '' : 'un'}check "ratings_#{rating}"}
  end
end

Then /I should see all the stores/ do
  # Make sure that all the stores in the app are visible in the table
  Store.all.each do |store|
    if ['G', 'PG', 'PG-13', 'R'].include? store.rating
      step %{I should see "#{store.name}"}
    end
  end
end
