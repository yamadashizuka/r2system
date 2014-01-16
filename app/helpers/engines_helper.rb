# coding: utf-8
module EnginesHelper
  # Engine#displaySuspend_orNot を、このヘルパークラスに移動しました。
  def display_suspended_or_not(engine)
    if engine.suspended?
      "<b>***サスペンド中***</b>".html_safe
    else
      ""
    end
  end
end
