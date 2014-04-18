module ApplicationHelper
  def anchor_path
    flash[:anchor_path] || :back
  end
end
