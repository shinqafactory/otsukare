# encoding: utf-8

module TopsHelper
  
  # entry_id, user_idを元にボタンの制御を行います　true:表示, false:非表示
  def is_exists(entry_id, user_id)
    
    @consent = Consent.find(
      :all,
      :conditions => [
        "entry_id = ? and (user_id = ? or consent_user_id = ?)",
        entry_id, user_id, user_id
      ]
    )
    
    if @consent.count > 0
      return false
    else
      return true
    end
    
  end
  
  #数を取得
  def get_consent_count(entry_id)
    @consent = Consent.find(:all, :conditions => ["entry_id = ?", entry_id])
    return @consent.count
  end

end
