module ApplicationHelper
  
  def get_user_name(user_id)
    name = ""
    
    @user = User.where(["id = ?", user_id.to_s])
    @user.each do |user|
      name = user.name
    end

    return name
  end
end
