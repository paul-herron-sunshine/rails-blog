module ApplicationHelper
  def full_title(page_title = '')
    base_title = "OTB Academy Blog 2018"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def get_num_users
    User.all.count
  end
end
