require 'faker'

namespace :db do 
	desc "Fill database with sample data"
	task :populate => :environment do
	  Rake::Task['db:reset'].invoke

       admin= User.create!(:name=> "Ret",
	  			       	   :email=> "ret@ret.com",
	  				       :password => "roflcopter",
	  				   	   :password_confirmation => "roflcopter")
       admin.toggle!(:admin)
	  99.times do |n|
	  	name = Faker::Name.name
	  	email = "example-#{n+1}@railstutorial.org"
	  	password = "password"
	  	User.create!(:name => name,
	  				 :email => email,
	  				 :password=> password,
	  				 :password_confirmation => password)	
	  end

	  50.times do 
	  	admin.envios.create!(:content => Faker::Lorem.sentence(5))
	  end
	  #User.all(:limit => 6).each do |user|
	  	#50.times do
	  	#  user.envios.create!(:content => Faker::Lorem.sentence(5))
	  	#end 
	  	#doesnt work idk y? 
	  #end

	  users=User.all 
	  user=users.first
	  following = users[1..50]
	  followers = users[3..40]
	  following.each { |followed| user.follow! (followed)}
	  followers.each { |follower| follower.follow!(user)}
	end
end