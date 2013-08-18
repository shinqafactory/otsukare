# encoding: utf-8

class ConsentsController < ApplicationController
  
  def is_exists
    @consent = Consent.find(
      :all,
      :conditions => [
        "entry_id = ? and (user_id = ? or consent_user_id = ?)",
        params[:entry_id], params[:user_id], params[:user_id]
      ]
    )
  end
  
  def create
    
    @consent = Consent.new(params[:consent])
      
    respond_to do |format|
      if @consent.save
        format.html { redirect_to :controller => 'tops', :action => 'index' }
      else
        @entries = Entry.find(:all, :conditions => {:display_flg => 0}, :order => "created_at DESC")
        format.html { render :template => "tops/index" }
        format.json { render json: @message_new.errors, status: :unprocessable_entity }
        format.json { render json: @entries }
      end
    end
    @entry_new = Entry.new
    
  end
  
end
