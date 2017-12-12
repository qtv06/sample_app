module ApplicationHelper
  # return title for per pages
  def full_title title_page = ""
    base_title = I18n.t ".base_title"
    if title_page.empty?
      base_title
    else
      title_page + " | " + base_title
    end
  end
end
