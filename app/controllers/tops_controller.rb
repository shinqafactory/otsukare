# encoding: utf-8

class TopsController < ApplicationController
  
  #ログイン後のページ初期表示
  #表示順は新着順で表示
  def index
    @entry_new = Entry.new
    #@entries = Entry.where(["display_flg = 0"]).order("created_at DESC").limit(1)
  end
  
  #otsukare投稿
  def create
    @entries = Entry.where(["display_flg = 0"]).order("created_at DESC")
    @entry_new = Entry.new(params[:entry])
    @user = current_user
    
    #display_flg 「0:表示」を設定
    @entry_new.display_flg = 0
    #ログインユーザーを設定
    @entry_new.user_id = @user.id
    
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
  
  #otsukare投稿削除
  #論理削除を行う
  #TODO ログイン処理未実装のため、ログインユーザーに紐づく削除は後回し
  def destroy
    @entry = Entry.find(params[:id])
    # 削除を設定
    @entry.display_flg = '1'

    respond_to do |format|
      if @entry.update_attributes(params[:entry])
        format.html { redirect_to :controller => 'tops', :action => 'index', notice: 'deleted.' }
      else
        format.html { render action: "index" }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end
  
end
