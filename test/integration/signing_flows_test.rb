# coding: utf-8

require 'test_helper'

class SigningFlowsTest < ActionDispatch::IntegrationTest
  fixtures :users, :companies

  # [正常系] 妥当なユーザ情報を入力してサインアップ -> サインアウト
  # users テーブルにレコードを追加して、メニュー画面に遷移することを確認
  test "sign up with valid user information and then sign out" do
    get root_path
    assert_redirected_to new_user_session_path

    assert_difference "User.count" do
      start_signing_up
      post user_registration_path, user: {
        userid: "YA900001",
        name: "てすと花子",
        email: "YA900001@test.org",
        password: "passpass",
        password_confirmation: "passpass",
        company_id: companies(:company1).id
      }
      assert_redirected_to root_path
    end

    new_user = User.find_by_userid("YA900001")
    assert_not_nil new_user
    assert_equal "てすと花子", new_user.name
    assert_not_nil new_user.last_sign_in_at

    sign_out
  end

  # [異常系] ユーザ ID を入力しないでサインアップ
  # users テーブルに変化が無いことを確認
  test "try to sign up without userid" do
    assert_no_difference "User.count" do
      start_signing_up
      post user_registration_path, user: {
        userid: "", # A userid must not be empty
        name: "てすと花子",
        email: "YA900001@test.org",
        password: "passpass",
        password_confirmation: "passpass",
        company_id: companies(:company1).id
      }
      assert_response :success
    end
  end

  # [異常系] 他のユーザと同じユーザ ID を入力してサインアップ
  # users テーブルに変化が無いことを確認
  test "try to sign up with userid same as one of existing user" do
    assert_no_difference "User.count" do
      start_signing_up
      post user_registration_path, user: {
        userid: "YA000001", # A userid must be unique
        name: "てすと花子",
        email: "YA900001@test.org",
        password: "passpass",
        password_confirmation: "passpass",
        company_id: companies(:company1).id
      }
      assert_response :success
    end
  end

  # [異常系] フォーマットが妥当ではないユーザ ID を入力してサインアップ
  # users テーブルに変化が無いことを確認
  test "try to sign up with ill-formed userid" do
    assert_no_difference "User.count" do
      start_signing_up
      post user_registration_path, user: {
        userid: "900001", # A userid must match with /[a-z]{2}[0-9]{6}/i
        name: "てすと花子",
        email: "YA900001@test.org",
        password: "passpass",
        password_confirmation: "passpass",
        company_id: companies(:company1).id
      }
      assert_response :success
    end
  end

  # [異常系] ユーザ名を入力しないでサインアップ
  # users テーブルに変化が無いことを確認
  test "try to sign up without name" do
    assert_no_difference "User.count" do
      start_signing_up
      post user_registration_path, user: {
        userid: "YA900001",
        name: "", # A name must not be empty
        email: "YA900001@test.org",
        password: "passpass",
        password_confirmation: "passpass",
        company_id: companies(:company1).id
      }
      assert_response :success
    end
  end

  # [正常系] サインアップ済みのユーザ ID でサインイン -> サインアウト
  # 正常にサインインし、メニュー画面に遷移、サインアウトリンク押下により正常に
  # サインアウトすることを確認
  test "sign in as existing user and then sign out" do
    get root_path
    assert_redirected_to new_user_session_path

    post user_session_path, user: {
      userid: users(:test_tarou).userid,
      password: "test0001"
    }
    assert_redirected_to root_path

    sign_out
  end

  # [異常系] サインアップしていないユーザ ID でサインイン
  # サインインせずに、サインイン画面に留まることを確認
  test "try to sign in with unknown userid" do
    get root_path
    assert_redirected_to new_user_session_path

    post user_session_path, user: {
      userid: "YA999999",
      password: "passpass"
    }
    assert_equal new_user_session_path, path
  end

  private
  def start_signing_up
    get new_user_registration_path
    assert_response :success
    assert_template "devise/registrations/new"
  end

  def sign_out
    delete destroy_user_session_path
    follow_redirect!
    assert_redirected_to new_user_session_path
  end
end
