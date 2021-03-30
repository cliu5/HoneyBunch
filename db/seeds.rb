# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

stores = [{:name => 'Gongcha', :rating => '4', :category => 'Drinks', :description => 'Gong Cha today is one of the most recognized bubble tea brands around the world. Known for quality tea and service, Gong Cha has withheld its reputation against many existing competitors.', :menu => 'Milk Tea,Green Tea', :image =>'https://www.gongchausa.com/wp-content/uploads/2016/02/TeaAndPearlsBanner320.png'},
          {:name => 'HMart', :rating => '3', :category => 'Groceries', :description => 'HMart is the largest Asian supermarket chain in America and is the pioneer of Asian food in America.', :menu => 'Ramen,Korean Fried Chicken', :image => 'https://cdn.vox-cdn.com/thumbor/HtPE36-UDBbBqkmo10tqKk29_Ek=/0x0:2048x1360/1200x800/filters:focal(861x517:1187x843)/cdn.vox-cdn.com/uploads/chorus_image/image/52683551/10648237_791550397560030_5178451302245274192_o.0.jpg'},
          {:name => 'Koronet', :rating => '4', :category => 'Italian', :description => 'Koronet Pizza is currently located at 2848 Broadway. Order your favorite pizza, pasta, salad, and more, all with the click of a button.', :menu => 'Pizza,Calzone', :image => 'https://media-cdn.tripadvisor.com/media/photo-p/08/ff/c5/17/koronet-pizzeria.jpg'},
          {:name => 'Morton Williams', :rating => '5', :category => 'Groceries', :description => 'Morton Williams is a family-owned and operated food retailer of fifteen stores in New York Metropolitan area - in business since 1946.', :menu => 'Broccoli,Kale', :image => 'https://upload.wikimedia.org/wikipedia/en/thumb/9/92/Morton_Williams_logo.svg/1200px-Morton_Williams_logo.svg.png'},
          {:name => 'Panda Express', :rating => '4', :category => 'Chinese', :description => 'Panda Express is an American fast food restaurant chain that serves American Chinese cuisine. With over 2,200 locations, it is the largest Asian segment restaurant chain in the United States.', :menu => 'Kung Pao Chicken,Fried Rice', :image => 'https://upload.wikimedia.org/wikipedia/en/thumb/8/85/Panda_Express_logo.svg/1200px-Panda_Express_logo.svg.png'},
          {:name => 'Famiglias', :rating => '3', :category => 'Italian', :description => ' Famous Famiglia, in the heart of New York City, serves up fresh, authentic New York style pizza in a fast, casual environment.', :menu => 'Pepperoni Pizza,Cheese Pizza', :image => 'https://orderfamigliapizza.com/slideimages/famous-famiglia-pizza-slider-logo.png'},
          {:name => 'Cafe East', :rating => '5', :category => 'Cafe', :description => 'Counter serve spot in the Columbia University Student Center for bubble tea, smoothies & Asian eats.', :menu => 'Boba pastries', :image => "https://arc-anglerfish-arc2-prod-spectator.s3.amazonaws.com/public/MI26VTDGIJCGXDWW6NU4MOIJ24"},
  	 ]

stores.each do |store|
  Store.create!(store)
end

