Otsukare::Application.routes.draw do

  devise_for :users
  #投稿(top)ページ
  root :to => 'tops#index'
  resources :tops, :only => [:index, :create, :destroy]
  resources :messages, :only => [:show, :create, :destroy]

  #messege投稿
  match 'messages/send_messege/:entry_id/:msg_to' => 'messages#send_messege', :via => :get
  #messege詳細
  match 'messages/detail/:id/:msg_from/:msg_to' => 'messages#detail', :via => :get
  
end
