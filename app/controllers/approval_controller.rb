class ApprovalController < ApplicationController
  
  def index
    @athletic_directors = AthleticDirector.where(accepted: nil).where.not(school_id: nil)
    @coaches = Relationship.where(accepted: nil, head: true)
  end
  
  def approve_director
    @athletic_director = AthleticDirector.find(params[:id])
    @athletic_director.update_attributes(accepted: true)
    @athletic_directors = AthleticDirector.where(accepted: nil).where.not(school_id: nil)
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end
  
  def approve_coach
    @coach = Relationship.find(params[:id])
    @coach.update_attributes(accepted: true)
    @coaches = Relationship.where(accepted: nil, head: true)
    respond_to do |format|
      format.js
      format.html { redirect_to :back }
    end
  end
  
end
