require 'test_helper'

class BusinessstatusesControllerTest < ActionController::TestCase
=begin
  setup do
    @businessstatus = businessstatuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:businessstatuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create businessstatus" do
    assert_difference('Businessstatus.count') do
      post :create, businessstatus: { name: @businessstatus.name }
    end

    assert_redirected_to businessstatus_path(assigns(:businessstatus))
  end

  test "should show businessstatus" do
    get :show, id: @businessstatus
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @businessstatus
    assert_response :success
  end

  test "should update businessstatus" do
    patch :update, id: @businessstatus, businessstatus: { name: @businessstatus.name }
    assert_redirected_to businessstatus_path(assigns(:businessstatus))
  end

  test "should destroy businessstatus" do
    assert_difference('Businessstatus.count', -1) do
      delete :destroy, id: @businessstatus
    end

    assert_redirected_to businessstatuses_path
  end
=end
end
