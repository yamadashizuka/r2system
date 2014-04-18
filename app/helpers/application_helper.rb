module ApplicationHelper
  def previous_path_like(base_path)
    session[:breadcrumbs].find { |s| s =~ /#{base_path}/ } || request.referrer
  end
end
