# encoding: utf-8

class TopsController < ApplicationController
  
  def index
    @entry = Entry.find(:all, :order => "created_at DESC")
  end
  
  def show
  end
  
  def new
    @entry = Entry.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @entry }
    end
  end
  
end
