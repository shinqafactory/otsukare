# encoding: utf-8

class TopsController < ApplicationController
  
  #ログイン後のページ初期表示
  def index
    @entry_new = Entry.new
    @entries = Entry.find(:all, :order => "created_at DESC")
  end
  
  def show
  end
  
  #otsukare投稿
  def create
    @entries = Entry.find(:all, :order => "created_at DESC")
    @entry_new = Entry.new(params[:entry])
    
    respond_to do |format|
      if @entry_new.save
        format.html { redirect_to :controller => 'tops', :action => 'index' }
      else
        format.html { render :template => "tops/index" }
        format.json { render json: @entry_new.errors, status: :unprocessable_entity }
        format.json { render json: @entries }
      end
    end
    @entry_new = Entry.new
  end
  
end
