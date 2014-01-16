require 'test_helper'

class EngineordersControllerTest < ActionController::TestCase
=begin
  setup do
    @engineorder = engineorders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:engineorders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create engineorder" do
    assert_difference('Engineorder.count') do
      post :create, engineorder: { branchCode: @engineorder.branchCode, changeComment: @engineorder.changeComment, deliveryDate: @engineorder.deliveryDate, inquiryDate: @engineorder.inquiryDate, issueNo: @engineorder.issueNo, loginUserId: @engineorder.loginUserId, machineNo: @engineorder.machineNo, orderDate: @engineorder.orderDate, orderer: @engineorder.orderer, placeCode: @engineorder.placeCode, sendingComment: @engineorder.sendingComment, sendingCompanyCode: @engineorder.sendingCompanyCode, timeOfRunning: @engineorder.timeOfRunning, userId: @engineorder.userId }
    end

    assert_redirected_to engineorder_path(assigns(:engineorder))
  end

  test "should show engineorder" do
    get :show, id: @engineorder
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @engineorder
    assert_response :success
  end

  test "should update engineorder" do
    patch :update, id: @engineorder, engineorder: { branchCode: @engineorder.branchCode, changeComment: @engineorder.changeComment, deliveryDate: @engineorder.deliveryDate, inquiryDate: @engineorder.inquiryDate, issueNo: @engineorder.issueNo, loginUserId: @engineorder.loginUserId, machineNo: @engineorder.machineNo, orderDate: @engineorder.orderDate, orderer: @engineorder.orderer, placeCode: @engineorder.placeCode, sendingComment: @engineorder.sendingComment, sendingCompanyCode: @engineorder.sendingCompanyCode, timeOfRunning: @engineorder.timeOfRunning, userId: @engineorder.userId }
    assert_redirected_to engineorder_path(assigns(:engineorder))
  end

  test "should destroy engineorder" do
    assert_difference('Engineorder.count', -1) do
      delete :destroy, id: @engineorder
    end

    assert_redirected_to engineorders_path
  end
=end
end
