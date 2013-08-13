class Message < ActiveRecord::Base
  attr_accessible :user_id, :msg_to, :msg_from, :subject, :body, :link_id, :thx_point, :reply_id, :created_at, :updated_at

end
