module ApplicationHelper
  def fix_url(str)
    str.starts_with?("http://") ? str : "http://#{str}"
  end
  def display_datetime(dt)
    # Time.zone = "Taipei"
    str = dt.strftime("%Y/%m/%d %p %H:%M:%S")
  end
end
