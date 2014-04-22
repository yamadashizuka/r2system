module EngineordersHelper

#画面上の編集可否を返す（受注画面）
def getDisabled_Ordered
  #本社の人は編集可能
  if current_user.yesOffice?
    return {
      :inquiry_date => false,
      :branch => false,
      :salesman_id => false,
      :install_place => false,
      :orderer => false,
      :old_engine_id => false,
      :time_of_running => false,
      :day_of_test => false,
      :change_comment => false
      }
  else
    return  {
      :inquiry_date => true,
      :branch => true,
      :salesman_id => true,
      :install_place => true,
      :orderer => true,
      :old_engine_id => true,
      :time_of_running => true,
      :day_of_test => true,
      :change_comment => true
      }
  end
end

#画面上の編集可否を返す（引当画面）
def getDisabled_Allocated
  if current_user.yesOffice?
    return {
      :inquiry_date => false,
      :order_date => false,
      :branch => false,
      :salesman_id => false,
      :install_place => false,
      :orderer => false,
      :old_engine_id => false,
      :time_of_running => false,
      :day_of_test => false,
      :change_comment => false,
      :sending_place => false,
      :sending_comment => false,
      :desirable_delivery_date => false
      }
  else
    return  {
      :inquiry_date => true,
      :order_date => true,
      :branch => true,
      :salesman_id => true,
      :install_place => true,
      :orderer => true,
      :old_engine_id => true,
      :time_of_running => true,
      :day_of_test => true,
      :change_comment => true,
      :sending_place => true,
      :sending_comment => true,
      :desirable_delivery_date => true
      }
  end
end

	#画面上の編集可否を返す（出荷画面）
def getDisabled_Shipped
  if current_user.yesOffice?
    return {
      :inquiry_date => false,
      :order_date => false,
      :branch => false,
      :salesman_id => false,
      :install_place => false,
      :orderer => false,
      :old_engine_id => false,
      :time_of_running => false,
      :day_of_test => false,
      :change_comment => false,
      :sending_place => false,
      :sending_comment => false,
      :desirable_delivery_date => false,
      :allocated_date => false

      }
  else
      return  {
      :inquiry_date => true,
      :order_date => true,
      :branch => true,
      :salesman_id => true,
      :install_place => true,
      :orderer => true,
      :old_engine_id => true,
      :time_of_running => true,
      :day_of_test => true,
      :change_comment => true,
      :sending_place => true,
      :sending_comment => true,
      :desirable_delivery_date => true,
      :allocated_date => true
      }
  end
end

#画面の項目編集可否を取得する（返却画面）
def getDisabled_Returning
  if current_user.yesOffice?
    return {
      :inquiry_date => false,
      :order_date => false,
      :branch => false,
      :salesman_id => false,
      :install_place => false,
      :orderer => false,
      :old_engine_id => false,
      :time_of_running => false,
      :day_of_test => false,
      :change_comment => false,
      :sending_place => false,
      :sending_comment => false,
      :desirable_delivery_date => false,
      :allocated_date => false,
      :invoice_no_new => false,
      :new_engine_id => false,
      :shipped_date => false,
      :shipped_comment => false
      }
  else
      return  {
      :inquiry_date => true,
      :order_date => true,
      :branch => true,
      :salesman_id => true,
      :install_place => true,
      :orderer => true,
      :old_engine_id => true,
      :time_of_running => true,
      :day_of_test => true,
      :change_comment => true,
      :sending_place => true,
      :sending_comment => true,
      :desirable_delivery_date => true,
      :allocated_date => true,
      :invoice_no_new => true,
      :new_engine_id => true,
      :shipped_date => true,
      :shipped_comment => true
      }
  end
end

end
