# coding: utf-8

require 'test_helper'

class MasterMaintenanceFlowsTest < ActionDispatch::IntegrationTest
  fixtures :users, :companies

  # [正常系] 法人マスタデータを一覧
  # companies フィクスチャで設定した法人をすべて表示することを確認
  test "list companies" do
    sign_in
    get companies_path

    trs = assert_select "body > table > tbody > tr"
    assert_equal 9, trs.size
    trs.each_with_index do |tr, idx|
      assert_select "td", minimum: 6
      fixture = companies("company#{idx + 1}".intern)
      assert_select "td:nth-of-type(1)", text: fixture.name
      assert_select "td:nth-of-type(2)", text: fixture.category
      assert_select "td:nth-of-type(3)", text: fixture.postcode
      assert_select "td:nth-of-type(4)", text: fixture.address
      assert_select "td:nth-of-type(5)", text: fixture.phone_no
      assert_select "td:nth-of-type(6)", text: fixture.destination_name
    end
  end

  # [正常系] 妥当な法人情報を入力して法人マスタデータを登録
  # companies テーブルにレコードを追加することを確認
  test "register new company with valid company information" do
    sign_in
    get new_company_path

    assert_difference "Company.count" do
      post companies_path, company: {
        name: "株式会社 多賀大社",
        category: "神社",
        postcode: "522-0341",
        address: "滋賀県犬上郡多賀町大字多賀６０４",
        phone_no: "0749-99-9999",
        destination_name: "お多賀さん"
      }
    end

    new_company = Company.find_by_name("株式会社 多賀大社")
    assert_not_nil new_company
    assert_equal "お多賀さん", new_company.destination_name
  end

  private
  def sign_in
    post user_session_path, user: {
      userid: users(:test_tarou).userid,
      password: "test0001"
    }
    assert_redirected_to root_path
  end
end
