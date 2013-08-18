class Consent < ActiveRecord::Base
  attr_accessible :consent_user_id, :entry_id, :user_id, :created_at, :updated_at
  
end
