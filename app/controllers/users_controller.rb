# encoding: utf-8

class UsersController < ApplicationController
  
  def user_edit
    @user = User.find(params[:id])
    @prefecture_for_options = Prefecture.order( id: :asc ).all
          
  end
  
  # ユーザー登録
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to :controller => 'tops', :action => 'index' }
      else
        format.html { render action: "user_edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
      
  end
end
