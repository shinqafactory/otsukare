# encoding: utf-8

class MessagesController < ApplicationController
  
  # メッセージ一覧を表示する
  def show
    #ログインユーザーに紐づくメッセージの一覧を取引ユーザー毎に表示
    @messages = Message.
      where(["user_id = ? or msg_from = ? or msg_to = ?", params[:id], params[:id], params[:id]]).
      group("link_id, reply_id").
      order("created_at DESC")
  end
  
  # メッセージ詳細を表示する
  def detail
        
    @messages = Message.where(["link_id = ? and reply_id = ?",params[:link_id], params[:reply_id]]).order("created_at DESC")
    
    @user = current_user    

    #返信していなければ、返信用の値を設定
    if @messages.count == 1
      linkId = 0
      replyId = 0
      msgFrom = 0
      #IDを取得
      @messages.each do |messages|
        linkId = messages.link_id
        replyId = messages.reply_id
        msgFrom = messages.msg_from
      end
      @message_new = Message.new(user_id: @user.id, msg_from: @user.id, msg_to: msgFrom, link_id: linkId, reply_id: replyId)
    else
      #返信している場合は設定しない
      @message_new = Message.new()
    end
    
  end

  #messege送信
  def send_messege
    
    @user = current_user    
    
    #既にメッセージを送っている場合はメッセージ詳細にリダイレクト
    @message = Message.where(["link_id = ? and msg_from = ?", params[:entry_id], @user.id])
    
    if @message.present?
      @message.each do |message|
        redirect_to :controller => 'messages', :action => 'detail', :link_id => message.link_id, :reply_id => message.reply_id
      end
    end
    
    #　enttry情報を取得する
    @entry = Entry.where(["display_flg = ? and id = ?", 0, params[:entry_id]])

    # 初期値設定 
    @message_new = Message.new(
      link_id: params[:entry_id], msg_to: params[:msg_to], msg_from: @user.id, user_id: @user.id)

  end
    
  #messege返信
  def create
    @message_new = Message.new(params[:message])
      
    if @message_new.reply_id.nil?
      @message_new.reply_id = Time.now.to_i
    end
    
    respond_to do |format|
      if @message_new.save
        format.html { redirect_to :controller => 'messages', :action => 'show', :id => @message_new.user_id }
      else
        @entries = Entry.where(["display_flg = 0"]).order("created_at DESC")
        format.html { render :template => "tops/index" }
        format.json { render json: @message_new.errors, status: :unprocessable_entity }
        format.json { render json: @entries }
      end
    end
    @entry_new = Entry.new
  end

end
