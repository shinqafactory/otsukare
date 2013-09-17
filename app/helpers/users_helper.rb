# encoding: utf-8

module UsersHelper
  
  def get_age(age)
    case age
    when 0
      return "10代"
    when 1
      return "20代"
    when 2
      return "30代"
    when 3
      return "40代"
    when 4
      return "50代"
    when 5
      return "60代"
    else
      return "非公開"
    end 
  end
  
  def get_gender(gender)
    if gender == 0
      return "男性"
    elsif gender == 1
      return "女性"
    else
      return "非公開"
    end
  end
end
