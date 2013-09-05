Otsukare::Application.routes.draw do

  devise_for :users
  #投稿(top)ページ
  root :to => 'tops#index'
  resources :users, :only => [:update]
  resources :tops, :only => [:index, :create, :destroy]
  resources :messages, :only => [:show, :create, :destroy]

  match 'users/profile/:id' => 'users#user_edit', :via => :get

  #messege投稿
  match 'messages/send_messege/:entry_id/:msg_to' => 'messages#send_messege', :via => :get
  #messege詳細
  match 'messages/detail/:link_id/:reply_id' => 'messages#detail', :via => :get
  
  #お疲れボタン
  #post 'consents/consents_create' => 'consents#consents_create'
  resources :consents, :only => [:create]
end
