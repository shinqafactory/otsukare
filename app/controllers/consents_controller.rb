# encoding: utf-8

class ConsentsController < ApplicationController
  
#  def create
#    
#    @consent = Consent.new(params[:consent])
#      
#    respond_to do |format|
#      if @consent.save
#        format.html { redirect_to :controller => 'tops', :action => 'index' }
#      else
#        @entries = Entry.find(:all, :conditions => {:display_flg => 0}, :order => "created_at DESC")
#        format.html { render :template => "tops/index" }
#        format.json { render json: @message_new.errors, status: :unprocessable_entity }
#        format.json { render json: @entries }
#      end
#    end
#    @entry_new = Entry.new
#    
#  end

  # おつかれボタン処理
  def insConsent
    
    @consent = Consent.new(consent_user_id: params[:consent_user_id], entry_id: params[:entry_id], user_id: params[:user_id])
      
    respond_to do |format|
      if @consent.save
        format.html { redirect_to :controller => 'tops', :action => 'index' }
      else
#        @entries = Entry.find(:all, :conditions => {:display_flg => 0}, :order => "created_at DESC")
        format.html { render :template => "tops/index" }
        format.json { render json: @message_new.errors, status: :unprocessable_entity }
#        format.json { render json: @entries }
      end
    end
    @entry_new = Entry.new
    
  end
    
end
