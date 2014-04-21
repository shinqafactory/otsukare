Otsukare::Application.routes.draw do

  devise_for :users
  #投稿(top)ページ
  root :to => 'tops#index', :via => [:get, :post]
#  root :to => 'tops#index'
  resources :users, :only => [:update]
  resources :tops, :only => [:index, :create, :destroy]
  resources :messages, :only => [:show, :create, :destroy]

  match 'api/entry/:lim/:ofs' => 'entries#getEntryToJosn', :via => :get
  match 'users/profile/:id' => 'users#user_edit', :via => :get

  #messege投稿
  match 'messages/send_messege/:entry_id/:msg_to' => 'messages#send_messege', :via => :get
  #messege詳細
  match 'messages/detail/:link_id/:reply_id' => 'messages#detail', :via => :get
  
  #お疲れボタン
  match 'consents/insConsent/:consent_user_id/:entry_id/:user_id' => 'consents#insConsent', :via => :post
  #resources :consents, :only => [:create]
end
