# == Schema Information
#
# Table name: contests
#
#  active          :boolean
#  created_at      :datetime         not null
#  duration        :integer
#  file_size       :boolean
#  file_size_val   :integer
#  id              :integer          not null, primary key
#  memory_used     :boolean
#  memory_used_val :integer
#  name            :string(255)
#  run_time        :boolean
#  run_time_val    :integer
#  start_date      :datetime
#  status          :string(255)
#  updated_at      :datetime         not null
#

class Contest < ActiveRecord::Base
  attr_accessible :active, :duration, :status, :name, :start_date, :problem_ids, :memory_used,
                  :run_time, :file_size, :memory_used_val, :run_time_val, :file_size_val, :validate, :validate_val,
                  :user_id, :acm, :penalty_val

  has_many :problems
  has_many :solutions
  has_and_belongs_to_many :users
  has_and_belongs_to_many :problems


  scope :active, where("active = true")


  def type
    acm ? "ACM" : "CUSTOM"
  end


  def is_registered?(user)
    self.users.include? user
  end


  def team_scores
    results =[] 



    users.each do |user|                                                  start_date
      ts =TeamScore.new(username: user.username)


      problemsArray = []
      score = 0
      penalties = 0

      problems.each do |problem|


        sol = user.solutions.joins(:problem).where("problem_id = ?",problem.id).order("updated_at ASC")
        last_sol = sol.solved.last if sol.solved.last



    
        
        if sol.length==0
          problemsArray << "-" 
        else
          if sol.solved.last
            problemsArray << "#{sol.length} tries"
          else
            problemsArray << "#{sol.length} tries" 

          end
        end
      
      end

      ts.problems=  problemsArray

      contSol= user.count_solutions(self)

      ts.count= contSol   

      ts.score = score

      if acm?
        ts.score = 0 
        if user.solutions.size > 0 # check if the user has at least 1 solution
          ts.score = user.solutions.max_by{|s| s.solved_time || 0}.solved_time
          if ts.score  # check if the user has at least 1 solution SOLVED!
          else
            ts.score = 0  
          end
       end
      end

      results << ts

    end
    results.sort_by{ |ts|  [ts.count*-1, ts.score ] }
  end
  
end
