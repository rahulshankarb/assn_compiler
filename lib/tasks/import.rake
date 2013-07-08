require 'csv'

desc "Import users from csv file"
task :import => [:environment] do

  file = "db/users.csv"

  CSV.foreach(file, :headers => false) do |row|
    User.create! ({
      :username => row[0],
      :first_person => row[1],
      :password => row[2],
      :email => row[3],
      :active => true
    })
  end

end