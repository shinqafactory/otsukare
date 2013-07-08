class MessagesController < ApplicationController
  
  # メッセージ一覧を表示する
  def show
    #ログインユーザーに紐づくメッセージの一覧を取引ユーザー毎に表示
    @messages = Message.find(
      :all, 
      :conditions => {:user_id => params[:id], :to => params[:id]},
      :group => [:user_id, :msg_from], 
      :order => "created_at DESC"
    )
    
  end
end
