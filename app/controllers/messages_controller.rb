class MessagesController < ApplicationController
  
  # メッセージ一覧を表示する
  def show
    #ログインユーザーに紐づくメッセージの一覧を取引ユーザー毎に表示
    @messages = Message.find(
      :all, 
      :conditions => {:user_id => params[:id], :msg_to => params[:id]},
      :group => [:user_id, :msg_from], 
      :order => "created_at DESC"
    )
  end
  
  # メッセージ詳細を表示する
  def detail
    @message_new = Message.new
    @messages = Message.find(
      :all,
      :conditions => ["user_id = ? and (msg_from = ? or msg_to = ?)", params[:id], params[:msg_from], params[:msg_to]],
      :order => "created_at DESC"
    )
  end
end
