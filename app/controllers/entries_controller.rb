# encoding: utf-8

class EntriesController < ApplicationController
  
  #有効な投稿情報をjson形式で返却します
  def getEntryToJosn
    
    @sql = Entry.select("entries.id", "entries.user_id", "entries.content", "entries.created_at", "users.name").
      joins("left join users on users.id = entries.user_id").
      where(["entries.display_flg = 0"]).
      order("entries.created_at DESC").
      limit(params[:lim]).
      offset(params[:ofs])
      
    @result = {'resultCount' => @sql.count, 'results' => @sql }
    
    respond_to do |format|
      format.json { render :json => @result }
    end
    
  end
end
