# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

stores = [{:name => 'Aladdin', :rating => 'G', :description => '25-Nov-1992'},
    	  {:name => 'The Terminator', :rating => 'R', :description => '26-Oct-1984'},
    	  {:name => 'When Harry Met Sally', :rating => 'R', :description => '21-Jul-1989'},
      	  {:name => 'The Help', :rating => 'PG-13', :description => '10-Aug-2011'},
      	  {:name => 'Chocolat', :rating => 'PG-13', :description => '5-Jan-2001'},
      	  {:name => 'Amelie', :rating => 'R', :description => '25-Apr-2001'},
      	  {:name => '2001: A Space Odyssey', :rating => 'G', :description => '6-Apr-1968'},
      	  {:name => 'The Incredibles', :rating => 'PG', :description => '5-Nov-2004'},
      	  {:name => 'Raiders of the Lost Ark', :rating => 'PG', :description => '12-Jun-1981'},
      	  {:name => 'Chicken Run', :rating => 'G', :description => '21-Jun-2000'},
  	 ]

stores.each do |store|
  Store.create!(store)
end
