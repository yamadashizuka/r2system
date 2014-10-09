# coding: utf-8

require 'test_helper'

class ScenarioTest < AcceptanceTest
  fixtures :users, :companies, :enginestatuses, :businessstatuses, :paymentstatuses

  # シナリオ１(sprint#2)
  test "scenario1 of release0_8" do

    ###########################################################################
    # 1. 管轄外のエンジン２が SG に送られてきた [@SG]
    #    -> エンジンを新規登録して、そのエンジンを受領する
    ###########################################################################

    # 1.1. サインインする
    sign_in "SG000001", "password"
    save_screenshot "scenario1-1_1.png"
    # 1.2. エンジン一覧画面を開く
    click_link "エンジン一覧"
    save_screenshot "scenario1-1_2.png"
    # 1.3. エンジン新規登録画面を開く
    click_link "新規登録"
    save_screenshot "scenario1-1_3.png"
    # 1.4. エンジンを登録する
    fill_in "エンジン型式", with: "ENG0002"
    fill_in "エンジンNo.", with: "SN0001"
    save_screenshot "scenario1-1_4_1.png"
    click_button "登録"
    confirm
    save_screenshot "scenario1-1_4_2.png"
    # 1.5. エンジン一覧画面に戻る
    click_link "戻る"
    assert has_content? "ENG0002"
    save_screenshot "scenario1-1_5.png"
    # 1.6. 受領画面を開く
    within "tbody > tr:nth-of-type(6)" do
      click_link "受領"  # エンジン一覧の6行目にある受領ボタンをクリック
    end
    # 受領時は受領日の登録のみ
    # 受領日のデフォルトは当日日付なので通常はボタン押下のみ
    save_screenshot "scenario1-1_6_1.png"
    click_button "受領登録"
    confirm
    save_screenshot "scenario1-1_6_2.png"
    # 1.7. 整備作業一覧画面に移動する
    click_link "戻る"
    #登録したエンジンが一覧にあることを確認する
    within "tbody > tr:nth-of-type(6)" do
      assert_equal "整備前",  nth_tag(:td, 1).text # ステータス
      assert_equal "ENG0002", nth_tag(:td, 2).text # エンジン型式
      assert_equal "SN0001",  nth_tag(:td, 3).text # エンジンNo.
    end
    save_screenshot "scenario1-1_7.png"
    # 1.8. サインアウトする
    sign_out
    save_screenshot "scenario1-1_8.png"


    ###########################################################################
    # 2. エンジン２の整備依頼を行う [@AA]
    ###########################################################################

    # 2.1. サインインする
    sign_in "AA000001", "password"
    save_screenshot "scenario1-2_1.png"
    # 2.2. 整備作業一覧画面を開く
    click_link "整備会社作業一覧"
    save_screenshot "scenario1-2_2.png"
    # 2.3. 整備依頼画面を開く
    click_link "依頼"
    save_screenshot "scenario1-2_3_1.png"
    fill_in "工事No(仮)", with: "654321"
    select "2014", from: "repair[desirable_finish_date(1i)]" # 希望完成日(年)
    select "1",    from: "repair[desirable_finish_date(2i)]" # 希望完成日(月)
    select "15",   from: "repair[desirable_finish_date(3i)]" # 希望完成日(日)
    save_screenshot "scenario1-2_3_2.png"
    click_button "依頼"
    confirm
    save_screenshot "scenario1-2_3_3.png"
    # 2.4. 整備作業一覧画面に移動する
    click_link "戻る"
    save_screenshot "scenario1-2_3_3_2.png"
 
    #整備依頼をしたエンジンを一覧上で確認する
    #※データが多のでエンジン型式とエンジンNo.で検索する
    fill_in "search_engine_model_name", with: "ENG0002"
    fill_in "search_serialno", with: "SN0001"
    click_button "検索"

    #整備依頼をしたエンジンの完成希望日とステータスが
    #入力通りに登録されていることを確認
    save_screenshot "scenario1-2_3_3_3.png"
    within "tbody > tr" do
      assert_equal "2014/01/15", nth_tag(:td, 4).text # 完成希望日
      assert_equal "整備前", nth_tag(:td, 1).text   # ステータス
    end
    save_screenshot "scenario1-2_4.png"

    # 2.5. サインアウトする
    sign_out
    save_screenshot "scenario1-2_5.png"


    ###########################################################################
    # 3. エンジン２の整備を開始した [@SG]
    ###########################################################################

    # 3.1. サインインする
    sign_in "SG000001", "password"
    save_screenshot "scenario1-3_1.png"
    # 3.2. 整備作業一覧画面を開く
    click_link "整備会社作業一覧"
    save_screenshot "scenario1-3_2.png"
    # 3.3. 整備開始画面を開く
    click_link "開始"
    save_screenshot "scenario1-3_3_1.png"
    select "2014", from: "repair[estimated_finish_date(1i)]" # 予定完成日(年)
    select "1",    from: "repair[estimated_finish_date(2i)]" # 予定完成日(月)
    select "10",   from: "repair[estimated_finish_date(3i)]" # 予定完成日(日)
    comment = "整備がんばります！"
    fill_in "コメント(整備前)", with: comment
    save_screenshot "scenario1-3_3_2.png"
    click_button "開始"
    confirm
    save_screenshot "scenario1-3_3_3.png"
    # 3.4. 整備作業一覧画面に移動する
    click_link "戻る"
    save_screenshot "scenario1-3_3_3_1.png"

    #ステータスが変更されていることを確認する
    within "tbody > tr:nth-of-type(1)" do
      assert_equal "整備中", nth_tag(:td, 1).text # ステータス
    end
    save_screenshot "scenario1-3_4.png"
    # 3.9. サインアウトする
    sign_out


    ###########################################################################
    # 4. エンジン２の整備が完了した [@SG]
    ###########################################################################

    # 4.1. サインインする
    sign_in "SG000001", "password"
    save_screenshot "scenario1-4_1.png"
    # 4.2. 整備作業一覧画面を開く
    click_link "整備会社作業一覧"
    save_screenshot "scenario1-4_2.png"
    # 4.3. 整備完了画面を開く
    click_link "完了"
    save_screenshot "scenario1-4_3_1.png"
    select "2014", from: "repair[finish_date(1i)]" # 完了日(年)
    select "1",    from: "repair[finish_date(2i)]" # 完了日(月)
    select "9",    from: "repair[finish_date(3i)]" # 完了日(日)
    comment = "整備完了しました！"
    fill_in "コメント(完了)", with: comment
    save_screenshot "scenario1-4_3_2.png"
    click_button "完了"
    confirm
    save_screenshot "scenario1-4_3_3.png"
    # 4.4. 整備作業一覧画面に移動する
    click_link "戻る"
    within "tbody > tr:nth-of-type(1)" do
      assert_equal "2014/01/09", nth_tag(:td, 6).text # 整備完了日
      assert_equal "完成品", nth_tag(:td, 1).text     # ステータス
    end
    save_screenshot "scenario1-4_4.png"
    # 4.2. サインアウトする
    sign_out


    ###########################################################################
    # 5. エンジン１を使っているお客様から新たな引合が来た [@KT]
    ###########################################################################

    # 5.1. サインインする
    sign_in "KT000001", "password"
    save_screenshot "scenario1-5_1.png"
    # 5.2. 流通情報一覧画面を開く
    click_link "流通情報一覧"
    save_screenshot "scenario1-5_2.png"
    # 5.3. 引合登録画面を開く
    click_link "新規引合"
    save_screenshot "scenario1-5_3_1.png"
    fill_in "物件名", with: "ぶっけんめい"
    fill_in "engineorder_install_place_attributes_postcode", with: "123-4567"
    fill_in "engineorder_install_place_attributes_address",  with: "大阪市大淀区大淀中大淀町大淀１２３４"
    fill_in "engineorder_install_place_attributes_phone_no", with: "06-1111-2222"
    fill_in "engineorder_install_place_attributes_name",     with: "ダミー物件"
    fill_in "engineorder_install_place_attributes_destination_name",   with: "ご担当者さま"
    fill_in "engineorder_orderer",   with: "元受株式会社"
    select "エンジンモデル名1", from: "engineorder_old_engine_attributes_engine_model_name"
    fill_in "engineorder_old_engine_attributes_serialno",   with: "00000001"
    select "2000", from: "engineorder_day_of_test_1i" # 試運転日(年)
    select "12",   from: "engineorder_day_of_test_2i" # 試運転日(月)
    select "23",   from: "engineorder_day_of_test_3i" # 試運転日(日)
    comment = "ちょっと調子がおかしいので交換してください。"
    fill_in "engineorder_change_comment", with: comment
    select "2014", from: "engineorder[desirable_delivery_date(1i)]" # 希望納期(年)
    select "2",    from: "engineorder[desirable_delivery_date(2i)]" # 希望納期(月)
    select "10",   from: "engineorder[desirable_delivery_date(3i)]" # 希望納期(日)
    save_screenshot "scenario1-5_3_2.png"
    click_button "登録"
    confirm
    save_screenshot "scenario1-5_3_3.png"

    # 5.4. 流通情報一覧画面に移動する
    all(:link_or_button, "戻る")[1].click  #「戻る」ボタンが二つあるので一個目をクリックする
    save_screenshot "scenario1-5_3_3.png"

    click_link "メインメニュー"
    click_link "流通情報一覧"
    within "tbody > tr:nth-of-type(1)" do
      assert_equal "引合", nth_tag(:td, 1).text       # ステータス
      assert_equal "ぶっけんめい", nth_tag(:td, 2).text       # 物件名
      assert_equal "ダミー物件", nth_tag(:td, 3).text # 設置先
      assert_equal "201410-001", nth_tag(:td, 4).text # 発行No
      assert_equal "2014/02/10", nth_tag(:td, 6).text   # 希望納期
    end
    within "tbody > tr:nth-of-type(2)" do
#改行の書き方が分からないのでいったんコメントアウト      assert_equal "エンジンモデルコード1\n(00000001)", nth_tag(:td, 1).text # 返却エンジン
      assert_equal "YES名古屋営業", nth_tag(:td, 3).text # 拠点(ログインユーザーの属する拠点)
    end
    save_screenshot "scenario1-5_4.png"
    # 5.9. サインアウトする
    sign_out


    ###########################################################################
    # 6. めでたくご発注頂いた [@KT]
    ###########################################################################

    # 6.1. サインインする
    sign_in "KT000001", "password"
    save_screenshot "scenario1-6_1.png"
    # 6.2. 流通情報一覧画面を開く
    click_link "流通情報一覧"
    save_screenshot "scenario1-6_2.png"
    # 6.3. 受注登録画面を開く
    click_link "受注"
    save_screenshot "scenario1-6_3_1.png"
    assert_equal "ぶっけんめい", find_field("物件名").value
    fill_in "売上金額（見込）", with: "1000000"
    fill_in "engineorder_sending_place_attributes_postcode", with: "888-9999"
    fill_in "engineorder_sending_place_attributes_address",  with: "大阪市大淀区大淀中５６７８"
    fill_in "engineorder_sending_place_attributes_phone_no", with: "06-333-4444"
    fill_in "engineorder_sending_place_attributes_name",     with: "ダミー送付先"
    fill_in "engineorder_sending_place_attributes_destination_name",   with: "送付咲子"
    comment = "送付先担当の方には連絡済です。"
    fill_in "engineorder_sending_comment", with: comment

    save_screenshot "scenario1-6_3_2.png"
    click_button "受注登録"
    confirm
    save_screenshot "scenario1-6_3_3.png"

    # 6.4. 流通情報一覧画面に移動する
    all(:link_or_button, "戻る")[1].click  #「戻る」ボタンが二つあるので一個目をクリックする
    click_link "メインメニュー"
    click_link "流通情報一覧"
    within "tbody > tr:nth-of-type(1)" do
      assert_equal "受注", nth_tag(:td, 1).text        # ステータス
    end
    within "tbody > tr:nth-of-type(2)" do
      assert_equal "ダミー送付先", nth_tag(:td, 4).text # 送付先
    end
    save_screenshot "scenario1-6_4.png"
    # 6.9. サインアウトする
    sign_out


#####
# 2014/10/09 ここまではSprint10のコードで動く状態になっています
# この先はまた後で……
#####


    ###########################################################################
    # 7. エンジン２を引当てた (エンジン１の返却は別途行う) [@AA]
    ###########################################################################

    # 7.1. サインインする
    sign_in "AA000001", "password"
    save_screenshot "scenario1-7_1.png"
    # 7.2. 流通情報一覧画面を開く
    click_link "流通情報一覧"
    save_screenshot "scenario1-7_2.png"
    # 7.3. 引当登録画面を開く
    click_link "引当"
    save_screenshot "scenario1-7_3_1.png"
    select "ENG0002 ( SN0001 )", from: "新規エンジン"
    save_screenshot "scenario1-7_3_2.png"
    click_button "引当登録"
    confirm
    save_screenshot "scenario1-7_3_3.png"
    # 7.4. 流通情報一覧画面に移動する
    click_link "戻る"
    click_link "メインメニュー"
    click_link "流通情報一覧"
    within "table > tbody > tr:nth-of-type(1)" do
      assert_equal "出荷準備中", nth_tag(:td, 1).text # ステータス
    end
    within "table > tbody > tr:nth-of-type(2)" do
      assert_equal "1GPH00-KS (5)", nth_tag(:td, 1).text # 返却エンジン
      assert_equal "ENG0002 (SN0001)", nth_tag(:td, 2).text # 新規エンジン
    end
    save_screenshot "scenario1-7_4.png"
    # 7.9. サインアウトする
    sign_out


    ###########################################################################
    # 8. エンジン２を出荷した [@SG]
    ###########################################################################

    # 8.1. サインインする
    sign_in "SG000001", "password"
    save_screenshot "scenario1-8_1.png"
    # 8.2. 整備会社作業一覧画面を開く
    click_link "整備会社作業一覧"
    save_screenshot "scenario1-8_2.png"
    # 8.3. 出荷登録画面を開く
    click_link "出荷"
    save_screenshot "scenario1-8_3_1.png"
    fill_in "送り状No（新エンジン）", with: "201312-001-001"
    save_screenshot "scenario1-8_3_2.png"
    click_button "出荷登録"
    confirm
    save_screenshot "scenario1-8_3_3.png"
    # 8.4. 整備会社作業一覧画面に移動する
    click_link "戻る"
    click_link "メインメニュー"
    click_link "整備会社作業一覧"
    save_screenshot "scenario1-8_4.png"
    # 8.2. サインアウトする
    sign_out


    ###########################################################################
    # 9. エンジン１を返却した [@KT]
    ###########################################################################

    # 9.1. サインインする
    sign_in "KT000001", "password"
    save_screenshot "scenario1-9_1.png"
    # 9.2. 流通情報一覧画面を開く
    click_link "流通情報一覧"
    save_screenshot "scenario1-9_2.png"
    # 9.3. 返却登録画面を開く
    click_link "返却"
    save_screenshot "scenario1-9_3_1.png"
    fill_in "送り状No（旧エンジン）", with: "2014-002-015"
    select "西宮戎リペア", from: "engineorder[returning_place_id]" # 返却先
    select "2014", from: "engineorder[returning_date(1i)]"         # 返却日(年)
    select "2月",    from: "engineorder[returning_date(2i)]"       # 返却日(月)
    select "15",   from: "engineorder[returning_date(3i)]"         # 返却日(日)
    comment = "天地無用でお願いします。"
    fill_in "返却コメント", with: comment                          # 返却コメント
    save_screenshot "scenario1-9_3_2.png"
    click_button "返却登録"
    confirm
    save_screenshot "scenario1-9_3_3.png"
    # 9.4. 流通情報一覧画面に移動する
    click_link "戻る"
    click_link "メインメニュー"
    click_link "流通情報一覧"
    save_screenshot "scenario1-9_4.png"
    # 9.5. サインアウトする
    sign_out

  end
end
