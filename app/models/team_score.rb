class TeamScore
include ActiveModel::Conversion
attr_accessor :username, :problems, :count, :file_size_score, :run_time_score, :score
    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end

    end  
	def persisted?
	      false
	end
end