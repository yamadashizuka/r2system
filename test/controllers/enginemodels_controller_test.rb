require 'test_helper'

class EnginemodelsControllerTest < ActionController::TestCase
=begin
  setup do
    @enginemodel = enginemodels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:enginemodels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create enginemodel" do
    assert_difference('Enginemodel.count') do
      post :create, enginemodel: { modelcode: @enginemodel.modelcode, name: @enginemodel.name }
    end

    assert_redirected_to enginemodel_path(assigns(:enginemodel))
  end

  test "should show enginemodel" do
    get :show, id: @enginemodel
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @enginemodel
    assert_response :success
  end

  test "should update enginemodel" do
    patch :update, id: @enginemodel, enginemodel: { modelcode: @enginemodel.modelcode, name: @enginemodel.name }
    assert_redirected_to enginemodel_path(assigns(:enginemodel))
  end

  test "should destroy enginemodel" do
    assert_difference('Enginemodel.count', -1) do
      delete :destroy, id: @enginemodel
    end

    assert_redirected_to enginemodels_path
  end
=end
end
