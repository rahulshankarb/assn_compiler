# == Schema Information
#
# Table name: users
#
#  active           :boolean
#  admin            :boolean
#  created_at       :datetime         not null
#  crypted_password :string(255)
#  email            :string(255)      not null
#  first_person     :string(255)
#  id               :integer          not null, primary key
#  salt             :string(255)
#  second_person    :string(255)
#  third_person     :string(255)
#  updated_at       :datetime         not null
#  username         :string(255)      not null
#

class User < ActiveRecord::Base
  #include Humanizer
  #require_human_on :create
  authenticates_with_sorcery!
  attr_accessible :username, :first_person, :second_person, :third_person, :password, :email, :admin, :active, :humanizer_answer, :humanizer_question_id
  has_many :solutions
  has_and_belongs_to_many :contests

  scope :active, where("active = true")

  # VALIDATIONS
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i


  validates_presence_of :password, :on => :create
  
  validates_presence_of :username
  validates_presence_of :first_person
  validates_uniqueness_of :username

  validates :email, :presence => true, length: { maximum: 255 }, :format => { with: VALID_EMAIL_REGEX },
					  :uniqueness => { case_sensitive: false }

 before_save { |user| user.email = email.downcase }

  def score(contest)
    score = 0
    contest.problems.each do |problem| 

      solution = contest.solutions.solved.where("user_id = #{self.id} and problem_id = #{problem.id}").order("updated_at DESC").limit(1)[0]
      time = solution.solved_time if solution

      if time
        tries = contest.solutions.where("user_id = #{self.id} and problem_id = #{problem.id}").count
        if tries > 1
          score += (tries-1)*20
        end
        score += time
              
      end      
    end
    return score
  end

  def count_solutions(contest)
    return contest.solutions.solved.select("DISTINCT problem_id").where("user_id = #{self.id}").count
 
  end



 
end
