# encoding: utf-8

class EntriesController < ApplicationController
  
  #有効な投稿情報をjson形式で返却します
  def getEntryToJosn
    # ログインユーザー情報
    @user = current_user
    # 検索
    @sql = Entry.select(
      "entries.id",
      "entries.user_id",
      "entries.content",
      "entries.created_at",
      "users.name",
      "(select count(consents.id) from consents where consents.entry_id = entries.id) as consent_count",
      "(select count(consents.id) from consents where consents.entry_id = entries.id and (consents.user_id = " + @user.id.to_s + " or consents.consent_user_id = " + @user.id.to_s + ")) as check_count").
      joins("left join users on users.id = entries.user_id").
      where(["entries.display_flg = 0"]).
      order("entries.created_at DESC").
      limit(params[:lim]).
      offset(params[:ofs])
      
    @result = {'resultCount' => @sql.count, 'results' => @sql, 'loginUserId' => @user.id }
    
    respond_to do |format|
      format.json { render :json => @result }
    end
    
  end
end
