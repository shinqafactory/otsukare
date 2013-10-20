# encoding: utf-8

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  attr_accessible :name, :password, :email, :password_confirmation, :age, :occupation, :gender, :residence
  
  #ユーザー名（name）の入力チェック
#  validates :name, :presence => true,                  #必須チェック
#  :length => { :minimum => 1, :maximum => 10 , :allow_blank => true } #入力文字数チェック10文字以内

end
