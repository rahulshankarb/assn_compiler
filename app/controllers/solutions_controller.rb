class SolutionsController < ApplicationController

 before_filter :require_login

 respond_to :html, :json, :js


 def index
  @solutions = Solution.all
  @user = User.find(current_user.id)
  respond_with(@solutions)
 end


  def show
    @solution = Solution.find(params[:id])
    respond_with(@solution)
  end


  def new
    @user = User.find(current_user.id)
    @solution = Solution.new
    @contest = Contest.find(params[:contest_id])
    flash[:notice] = "coming to new"
#    respond_with(@solution)

  end


  # POST /solutions
  # POST /solutions.json
  def create

#    @solution = Solution.new(params[:solution])
   @user = User.new(params[:user])
    @solution = Solution.new(params[:solution])
    @user = User.find(current_user.id)
    @solution.state = State.find_by_acronym('UN')

    flash[:notice] = "coming but not saving"
#    if able?

      if @solution.save
        flash[:notice] = "Saving"

       #@solution.delay.judge # with background jobs
       @solution.judge # without background jobs
      end
 #   else
      # notice
 #     flash[:error] = "Submissions for this assignment are closed"
  #    @solution.contest.status = "finish"
  #    @solution.contest.save
  #  end

    redirect_to(dashboard_path(@solution.contest))
    
  end

  
  def able? #this function check whenever the user is able to send submissions
    DateTime.now < @solution.contest.start_date + (@solution.contest.duration * 3600)
  end

end





