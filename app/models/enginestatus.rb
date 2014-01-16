class Enginestatus < ActiveRecord::Base
  # config/initializers/constants.rb で定義した ID_* 定数を取り込んでいます。
  include Constants::Enginestatus
  include Constants::Businessstatus


  # 他のコードで、マスタデータの id を直接使わないように、マスタデータそのもの
  # を簡単に取得できるようにしました。
  def self.of_before_arrive;   find(ID_BEFORE_ARRIVE) end
  def self.of_before_repair;   find(ID_BEFORE_REPAIR) end
  def self.of_under_repair;    find(ID_UNDER_REPAIR) end
  def self.of_finished_repair; find(ID_FINISHED_REPAIR) end
  def self.of_before_shipping; find(ID_BEFORE_SHIPPING) end
  def self.of_after_shipping;  find(ID_AFTER_SHIPPING) end
  def self.of_about_to_return; find(ID_ABOUT_TO_RETURN) end
  def self.of_abolished;       find(ID_ABOLISHED) end
end
