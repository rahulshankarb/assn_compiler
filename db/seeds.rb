

def clean
	State.destroy_all
	User.destroy_all
	Problem.destroy_all
	Solution.destroy_all
end


def make_states
	State.create!(name: "Accepted", acronym: "AC")
	State.create!(name: "Wrong Answer", acronym: "WA")
	State.create!(name: "Time Limit Exceeded", acronym: "TL")
	State.create!(name: "Compile Error", acronym: "CE")
	State.create!(name: "Unjudged", acronym: "UN")

end

def make_admin
	User.create!(username: "admin",
		first_person: "Rahul",
		second_person: "admin",
		third_person: "admin",
		email: "shankar.rahi@gmail.com",
		password: "admin",
		admin: true,
		active: true
		)

end

def make_users
	30.times do |n|
		username  = "team#{n}"
		email = "team#{n}@team.com"
		password  = "team#{n}"
		first_person  = "team#{n}"
		second_person  = "team#{n}"
		third_person  = "team#{n}"

		User.create!(username:     username,
			email:    email,
			password: password,
			first_person: first_person,
			second_person: second_person,
			third_person: third_person,
			active: true
			)
	end  
end

def make_user_default

	User.create!(username:     "team",
		email:    "team@team.com",
		password: "team",
		first_person: "Rahul",
		second_person: "Shankar",
		third_person: "Bhardwaj",
		active: true
		)
end

#def make_fake_problems

#	50.times do |n|
#		title = Faker::Company.bs
#		Problem.create!(title: title,
#			time:   5,
#			active: true
#			)
#	end
#end

clean
make_states
make_admin
make_users
make_user_default

