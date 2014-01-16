# coding: utf-8

require 'test_helper'

class MasterMaintenanceFlowsTest < AcceptanceTest
  fixtures :users, :companies

  # [正常系] 法人マスタデータを一覧
  # companies フィクスチャで設定した法人をすべて表示することを確認
  test "list companies" do
    sign_in "AA000001", "password"

    click_link "法人"

    assert has_content? "YES本社"
    assert has_content? "西宮戎リペア"
    assert has_content? "大須観音工機"
    assert has_content? "川口住宅設備"
    assert has_content? "巣鴨空調設備"
    assert has_content? "聖路加病院"
    assert has_content? "法華倶楽部"
    assert has_content? "YES名古屋営業"
    assert has_content? "YES大阪営業"

    sign_out
  end

  # [正常系] 妥当な法人情報を入力して法人マスタデータを登録
  # companies テーブルにレコードを追加することを確認
  test "register new company with valid company information" do
    sign_in "AA000001", "password"

    click_link "法人"
    click_link "新規登録"

    assert_difference "Company.count" do
      fill_in "company_name", with: "株式会社 多賀大社"
      fill_in "company_category", with: "神社"
      fill_in "company_postcode", with: "522-0341"
      fill_in "company_address", with: "滋賀県犬上郡多賀町大字多賀６０４"
      fill_in "company_phone_no", with: "0749-99-9999"
      fill_in "company_destination_name", with: "お多賀さん"
      click_button "登録する"
    end

    new_company = Company.find_by_name("株式会社 多賀大社")
    assert_not_nil new_company
    assert_equal "お多賀さん", new_company.destination_name

    assert_equal company_path(new_company), current_path
    assert has_content? "株式会社 多賀大社"

    sign_out
  end
end
