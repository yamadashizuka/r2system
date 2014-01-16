require 'test_helper'

class EnginestatusesControllerTest < ActionController::TestCase
=begin
  setup do
    @enginestatus = enginestatuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:enginestatuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create enginestatus" do
    assert_difference('Enginestatus.count') do
      post :create, enginestatus: { name: @enginestatus.name }
    end

    assert_redirected_to enginestatus_path(assigns(:enginestatus))
  end

  test "should show enginestatus" do
    get :show, id: @enginestatus
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @enginestatus
    assert_response :success
  end

  test "should update enginestatus" do
    patch :update, id: @enginestatus, enginestatus: { name: @enginestatus.name }
    assert_redirected_to enginestatus_path(assigns(:enginestatus))
  end

  test "should destroy enginestatus" do
    assert_difference('Enginestatus.count', -1) do
      delete :destroy, id: @enginestatus
    end

    assert_redirected_to enginestatuses_path
  end
=end
end
