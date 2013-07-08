class StaticPagesController < ApplicationController
  before_filter :require_login, :only => [:dashboard]

  respond_to :html, :json, :js


  def home
  	redirect_to(login_url) unless current_user
  end

  def help
  end

  def error
    
  end



  def dashboard    
    @contest = Contest.find(params[:id])
    @user = User.find(current_user.id)
    @solutions = @user.solutions.where("contest_id = #{@contest.id}").order("id DESC").page(params[:page]).per(5)
    #@user.solutions.find_by_contest_id(@contest.id) # this will return nil
    @solution = Solution.new

    #timer

    if @contest.start_date < DateTime.now
    #if @contest.start_date < DateTime.now+5.hours+30.minutes 

      #array = time_diff(@contest.start_date, DateTime.now+5.hours+30.minutes) #india time
      #array = time_diff(@contest.start_date, DateTime.now-5.hours) #colombia time
      array = time_diff(@contest.start_date, DateTime.now) #fixed time

      @remaining = array[3]*3600 + array[4]*60+ array[5]
      #{years,months,days,hours,minutes,seconds}



      if @remaining <  @contest.duration * 3600 
          @remaining = (@contest.duration * 3600)-@remaining 
        else
          @remaining = 0
      end
    else
      @remaining = -1
    end
    #timer


  end

  def getPdf

    @contest = Contest.find(params[:id])

    respond_to do |format|
      format.html
      format.js
      format.pdf{
        render :pdf=>"report",
        :template => 'contests/_positions.html.erb',   
        :layout => 'pdflayout.html'     
      }
    end
    
  end


  private

  def  time_diff(from_time, to_time)
        %w(year month day hour minute second).map do |interval|
      distance_in_seconds = (to_time.to_i - from_time.to_i).round(1)
      delta = (distance_in_seconds / 1.send(interval)).floor
      delta -= 1 if from_time + delta.send(interval) > to_time
      from_time += delta.send(interval)
      delta
    end
  end
end

