class ReportMailer < ActionMailer::Base
  default from: "abc@abc.com"

  def report(id) 
    @contest = Contest.find(id)
      emails =@contest.users.map {|u|u.email}.join(", ")
      mail to:emails , subject: "Contest Report #{@contest.name}"
    
  end
end