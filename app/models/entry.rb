# encoding: utf-8

class Entry < ActiveRecord::Base
  attr_accessible :user_id, :content, :created_at, :updated_at, :display_flg
  
  #投稿（content）の入力チェック
  validates :content, :presence => true,                  #必須チェック
  :length => { :minimum => 1, :maximum => 140 , :allow_blank => true } #入力文字数チェック140文字以内

end
