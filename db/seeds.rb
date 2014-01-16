# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# マスタデータの id 値定数を参照するため。
require_relative "../config/initializers/constants"

# db/seeds.rb は、稼働用の仕込みデータを作成できます。
# データの作成は、ふつうに ActiveRecord の機能で行えます。
# アプリの初回セットアップ時に rake db:seed でデータを仕込みますが、念のため何
# 度も実行できるよう、データ作成前に既存データを削除しています。
# データの削除を delete_all で書いているので、取扱いにはご注意ください。。

# データは test/fixtures/businessstatuses.yml からリバース
Businessstatus.delete_all
Businessstatus.create([
  {name: "引合",       id: Businessstatus::ID_INQUIRY},
  {name: "受注",       id: Businessstatus::ID_ORDERED},
  {name: "出荷準備中", id: Businessstatus::ID_SHIPPING_PREPARATION},
  {name: "出荷済",     id: Businessstatus::ID_SHIPPED},
  {name: "返却済",     id: Businessstatus::ID_RETURNED},
  {name: "キャンセル", id: Businessstatus::ID_CANCELED}
])

# データは test/fixtures/enginestatuses.yml からリバース
Enginestatus.delete_all
Enginestatus.create([
  {name: "受領前",     id: Enginestatus::ID_BEFORE_ARRIVE},
  {name: "整備前",     id: Enginestatus::ID_BEFORE_REPAIR},
  {name: "整備中",     id: Enginestatus::ID_UNDER_REPAIR},
  {name: "完成品",     id: Enginestatus::ID_FINISHED_REPAIR},
  {name: "出荷準備中", id: Enginestatus::ID_BEFORE_SHIPPING},
  {name: "出荷済",     id: Enginestatus::ID_AFTER_SHIPPING},
  {name: "返却予定",   id: Enginestatus::ID_ABOUT_TO_RETURN},
  {name: "廃却済",     id: Enginestatus::ID_ABOLISHED}
])

# データは test/fixtures/companies.yml からリバース
Company.delete_all

aa = Company.create(
  name: "YES本社", category: "YES本社",
  postcode: "123-4567", address: "大阪市大淀区大淀中4丁目",
  phone_no: "06-6123-4567", destination_name: "荒井様")

kt = Company.create(
  name: "YES名古屋営業", category: "YES拠点",
  postcode: "432-1111", address: "名古屋市中区東新町",
  phone_no: "053-555-6666", destination_name: "豊田様")

sg = Company.create(
  name: "西宮戎リペア", category: "整備会社",
  postcode: "123-4567", address: "兵庫県西宮市戎西町",
  phone_no: "06-6123-4567", destination_name: "恵比寿様")

Company.create([
  {
    name: "大須観音工機", category: "整備会社",
    postcode: "123-4567", address: "名古屋市中区大須",
    phone_no: "06-6123-4567", destination_name: "観世音菩薩様"
  },
  {
    name: "川口住宅設備", category: "工事会社",
    postcode: "123-4568", address: "大阪市西区川口8丁目",
    phone_no: "06-6123-4567", destination_name: "基督様"
  },
  {
    name: "巣鴨空調設備", category: "工事会社",
    postcode: "123-4567", address: "東京都練馬区巣鴨",
    phone_no: "03-1234-5678", destination_name: "棘貫様"
  },
  {
    name: "聖路加病院", category: "顧客",
    postcode: "333-4567", address: "東京都江東区",
    phone_no: "03-1234-5678", destination_name: "万梨阿様"
  },
  {
    name: "法華倶楽部", category: "顧客",
    postcode: "333-4567", address: "大阪市東淀川区",
    phone_no: "06-6123-4567", destination_name: "法蓮華様"
  },
  {
    name: "YES大阪営業", category: "YES拠点",
    postcode: "123-4568", address: "大阪市大北区万歳町",
    phone_no: "06-6123-4567", destination_name: "大橋拠点"
  }
])

# データは test/fixtures/engines.yml からリバース
Engine.delete_all
Engine.create([
  {
    engine_model_name: "1GPH00-KS",
    sales_model_name: "YRZP000J-AA",
    serialno: "00000001",
    status: Enginestatus.of_before_arrive,
    company: aa
  },
  {
    engine_model_name: "1GPH00-KS",
    sales_model_name: "YRZP000J-AA",
    serialno: "00000002",
    status: Enginestatus.of_before_arrive,
    company: aa
  },
  {
    engine_model_name: "8GZZ00-AZ",
    sales_model_name: "YRZG000J-ZZ",
    serialno: "00000003",
    status: Enginestatus.of_before_arrive,
    company: aa
  },
  {
    engine_model_name: "5YES00-MS",
    sales_model_name: "YRZA000J-QP",
    serialno: "00000004",
    status: Enginestatus.of_before_arrive,
    company: aa
  },
  {
    engine_model_name: "1GPH00-KS",
    sales_model_name: "YRZP000J-AA",
    serialno: "00000005",
    status: Enginestatus.of_before_arrive,
    company: aa
  }
])

# データは test/fixtures/users.yml からリバース
User.delete_all
User.create([
  {
    name: "AA の人", company: aa,
    userid: "AA000001", email: "aa000001@test.org", password: "password"
  },
  {
    name: "KT の人", company: kt,
    userid: "KT000001", email: "kt000001@test.org", password: "password"
  },
  {
    name: "SG の人", company: sg,
    userid: "SG000001", email: "sg000001@test.org", password: "password"
  }
])
