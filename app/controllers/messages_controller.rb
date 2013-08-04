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
    @messages = Message.find(
      :all,
      :conditions => ["user_id = ? and (msg_from = ? or msg_to = ?)", params[:id], params[:msg_from], params[:msg_to]],
      :order => "created_at DESC"
    )
    
    #返信していなければ、返信用の値を設定
    if @messages.count == 1
      linkId = 0
      #IDを取得
      @messages.each do |messages|
        linkId = messages.id
      end
      @message_new = Message.new(user_id: params[:id], msg_from: params[:id], msg_to: params[:msg_from], link_id: linkId)
    else
      #返信している場合は設定しない
      @message_new = Message.new()
    end
    
  end

  #messege送信
  def send_messege
    
    # 初期値設定 TODO 本来はログインユーザー
    @message_new = Message.new(link_id: params[:entry_id], msg_to: params[:msg_to], msg_from: 1, user_id: 1)
    
    #　enttry情報を取得する
    @entry = Entry.find(
      :all, 
      :conditions => ["display_flg = ? and id = ?", 0, params[:entry_id]])
  end
    
  #messege返信
  def create
    @message_new = Message.new(params[:message])
    
    respond_to do |format|
      if @message_new.save
        format.html { redirect_to :controller => 'messages', :action => 'show', :id => @message_new.user_id }
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
