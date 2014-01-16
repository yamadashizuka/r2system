module EngineordersHelper

	#画面上の編集可否を返す（出荷画面）
def getDisabled_Shipped
  #整備会社の場合
  if current_user.tender?
      return  {
      	:title => true,
        :inquiry_date => true,
        :branch_id => true,
        :salesman_id => true,
        :install_place_id => true,
        :orderer => true,
        :time_of_running => true,
        :day_of_test => true,
        :change_comment => true,
        :desirable_delivery_date => true,
        :sending_place_id => true,
        :sending_comment => true
      }
  else
    return {
    	:title => false,
        :inquiry_date => false,
        :branch_id => false,
        :salesman_id => false,
        :install_place_id => false,
        :orderer => false,
        :time_of_running => false,
        :day_of_test => false,
        :change_comment => false,
        :desirable_delivery_date => false,
        :sending_place_id => false,
        :sending_comment => false
      }
  end
end


end
