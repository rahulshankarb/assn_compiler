class StatesController < ApplicationController
  before_filter :require_login
  respond_to :html, :json, :js
  # GET /states
  # GET /states.json
  def index
    @states = State.all
    respond_with(@states)
  end  
end
