require 'test_helper'

class EnginesControllerTest < ActionController::TestCase
=begin
  setup do
    @engine = engines(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:engines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create engine" do
    assert_difference('Engine.count') do
      post :create, engine: { engineModelName: @engine.engineModelName, salesModelName: @engine.salesModelName }
    end

    assert_redirected_to engine_path(assigns(:engine))
  end

  test "should show engine" do
    get :show, id: @engine
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @engine
    assert_response :success
  end

  test "should update engine" do
    patch :update, id: @engine, engine: { engineModelName: @engine.engineModelName, salesModelName: @engine.salesModelName }
    assert_redirected_to engine_path(assigns(:engine))
  end

  test "should destroy engine" do
    assert_difference('Engine.count', -1) do
      delete :destroy, id: @engine
    end

    assert_redirected_to engines_path
  end
=end
end
