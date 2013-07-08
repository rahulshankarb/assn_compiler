class ContestsController < ApplicationController
  load_and_authorize_resource
  check_authorization

  respond_to :html, :json, :js
  # GET /contests
  # GET /contests.json
  def index
    @contests = Contest.active
    respond_with(@contests)

  end

  # GET /contests/1
  # GET /contests/1.json
  def show
    @contest = Contest.find(params[:id])
    respond_with(@contest)
  end

  # GET /contests/new
  # GET /contests/new.json
  def new
    @contest = Contest.new
    @contest.validate = @contest.file_size = @contest.run_time = true # mandatory all for now    

    respond_with(@contest)
  end

  # GET /contests/1/edit
  def edit
    @contest = Contest.find(params[:id])
  end

  # POST /contests
  # POST /contests.json
  def create
    @contest = Contest.new(params[:contest])
    @contest.validate = @contest.file_size  = @contest.run_time= true  # mandatory all for now  
    @contest.file_size = true
    @contest.run_time = true
    @contest.active = true    
    @contest.status = "registration"
    flash[:success] = "Assignment was successfully created." if @contest.save
    redirect_to(admin_contests_path)
    
  end

  # PUT /contests/1
  # PUT /contests/1.json
  def update
    @contest = Contest.find(params[:id])

    flash[:success] = "Assignment was successfully updated." if @contest.update_attributes(params[:contest])
    redirect_to(admin_contests_path)

  end

  # DELETE /contests/1
  # DELETE /contests/1.json
  def destroy
    @contest = Contest.find(params[:id])
    @contest.destroy

    redirect_to(admin_contests_path)
  end

  def register
    @contest = Contest.find(params[:id])
    @contest.users.push(current_user)
    redirect_to(contests_path)
  
  end

  def unregister
    @contest = Contest.find(params[:id])
    @contest.users.destroy(current_user)
    redirect_to(contests_path)
    
  end

  def admin_index
    @contests = Contest.all
    respond_with(@contests)

  end

  def admin
    @solutions = Solution.order("id DESC")
    @contest = Contest.find(params[:id])



    
    if @contest.start_date < DateTime.now

     
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


    respond_with(@contests)


  end

  def report
    #puts "*********".red
    @contest = Contest.find(params[:id])
    ReportMailer.report(@contest.id).deliver
    redirect_to admin_contest_path(@contest)
  end

 

  def start
    @contest = Contest.find(params[:id])
    @contest.status = "start"
    @contest.save
    redirect_to admin_contest_path(@contest)
    
  end


  def active
    @contest = Contest.find(params[:id])
    @contest.status = "initial"
    @contest.active = true
    @contest.save
    redirect_to admin_contest_path(@contest)
    
  end

  def finalize
    @contest = Contest.find(params[:id])
    @contest.status = "finalize"    
    @contest.active = false
    @contest.save
    redirect_to admin_contest_path(@contest)
    
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
