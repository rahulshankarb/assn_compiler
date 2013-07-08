class ProblemsController < ApplicationController
  #before_filter :require_login, :only => [:new, :create, :update, :destroy, :edit]
  before_filter :require_login
  load_and_authorize_resource
  check_authorization
  
  respond_to :html, :json, :js


  # GET /problems
  # GET /problems.json
  def index
    @problems = Problem.active.order("title").page(params[:page]).per(10)
    respond_with(@problems)


  end

  # GET /problems/1
  # GET /problems/1.json
  def show
    @problem = Problem.find(params[:id])
    respond_with(@problem)

  end

  # GET /problems/new
  # GET /problems/new.json
  def new
    @problem = Problem.new
    respond_with(@problem)

  end

  # GET /problems/1/edit
  def edit
    @problem = Problem.find(params[:id])
  end

  # POST /problems
  # POST /problems.json
  def create
    @problem = Problem.new(params[:problem])
    @problem.active = true;
    @problem.size = ((@problem.judgeSolution_file_size.to_f/1024).round(2)).ceil

    flash[:success] = "Problem was successfully created." if @problem.save
    redirect_to(problems_path)

 end

  # PUT /problems/1
  # PUT /problems/1.json
  def update
    @problem = Problem.find(params[:id])

    flash[:success] = "Problem was successfully updated." if @problem.update_attributes(params[:problem])
    respond_with(@problem)

  end

  # DELETE /problems/1
  # DELETE /problems/1.json
  def destroy
    @problem = Problem.find(params[:id])
    @problem.active = false;
    @problem.save!;

    respond_to do |format|
      format.html { redirect_to problems_url }
      format.json { head :no_content }
    end
  end


  def autoimport
    
    path  = params[:path] unless params[:path].blank?
    size = params[:size] unless params[:size].blank?
    time  = params[:time] unless params[:time].blank?

    #default values
    path ||= File.join(Rails.root, "spec/problems")
    size ||= 500
    time ||= 5 
    
    ai = AutoImport.new(path, size, time)
    res= ai.import    
    flash[:success] = "#{res[:success]} problems successfully created." if res[:success] > 0
    flash[:error] = "#{res[:error]} with specification errors. RTFM" if res[:error] > 0

    redirect_to(problems_path)
  end
end
