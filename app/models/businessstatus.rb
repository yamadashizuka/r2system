class Businessstatus < ActiveRecord::Base
  # config/initializers/constants.rb で定義した ID_* 定数を取り込んでいます。
  include Constants::Businessstatus

  # 他のコードで、マスタデータの id を直接使わないように、マスタデータそのもの
  # を簡単に取得できるようにしました。
  def self.of_inquiry;              find(ID_INQUIRY) end
  def self.of_ordered;              find(ID_ORDERED) end
  def self.of_shipping_preparation; find(ID_SHIPPING_PREPARATION) end
  def self.of_shipped;              find(ID_SHIPPED) end
  def self.of_returned;             find(ID_RETURNED) end
  def self.of_canceled;             find(ID_CANCELED) end
end
