## r2 のテストについて

### 用語

1. 単体テスト
    * モデル毎のテストを test/models ディレクトリに作成します
    * Ruby on Rails 標準の枠組みに含まれる機能で作成できます
    * 各モデルに記述したロジックを詳細にテストしたい場合に作成します

2. 機能テスト
    * コントローラ毎のテストを test/controllers ディレクトリに作成します
    * Ruby on Rails 標準の枠組みに含まれる機能で作成できます
    * 各モデルと関連するコントローラとビューについて詳細にテストしたい場合に作成します

3. 統合テスト
    * 複数コントローラをまたぐワークフローのテストを test/integration ディレクトリに作成します
    * Ruby on Rails 標準の枠組みに含まれる機能で作成できます
    * 大きなワークフローを詳細にテストしたい場合に作成します

4. 受け入れテスト
    * ブラウザを操作することで、システム全体をブラックボックスとしてテストできます
    * テストは test/acceptance ディレクトリに作成します
    * Ruby on Rails 標準の枠組みに、後述の Capybara + Selenium を追加で利用しています
    * 1-3 のようなアプリケーション内部の仕組みを意識した詳細なテストではなく、あくまでユーザ視点のテストを行いたい場合に作成します

それぞれのテストがカバーする機能は、下図のようになります。

![各テストのカバー範囲](https://raw.github.com/yanoh/r2/develop/test/test.png)

テストで使用する Ruby on Rails に含まれないオプションパッケージは下記です。

* Selenium (セレニウム、セレン？)

    ブラウザも含めた (JavaScript も含めた) 自動テストのための OSS ツール。
    2004 年に ThoughtWorks が作り始めたものだそうです。

* Capybara (カピバラ)

    ウェブアプリをテストするための DSL で、Selenium と併用するとブラウザ操作を簡単に自動化できる。
    標準装備の Rack::Test モードなら、Rack を境界に画面無しでテストできるので、CI ツールによる自動実行もできる~~(はず)~~。
    * Travis CI では xvfb (X Virtual Frame Buffer) を使えば画面有りでテストできました。
    * ただ、保存したスクリーンショットをどうやって取得するかはまだ考えていません。

### 開発環境の構築

1. Ruby と Ruby on Rails をインストールする

    Windows 環境では [RailsInstaller](http://railsinstaller.org/) を使うと、Ruby + Ruby on Rails + Git を一括インストールできるので楽です。

2. リポジトリをクローンする

    コマンドプロンプトから下記コマンドで r2 をクローンします。

        > cd \
        > mkdir work
        > cd work
        > git clone https://github.com/yanoh/r2.git

3. r2 に必要なパッケージをインストールする

    コマンドプロンプトから下記コマンドで r2 に必要な gem パッケージをインストールします。

        > cd \work\r2
        > bundle install

4. Selenium の Internet Explorer Driver Server をインストールする

    受け入れテストに Internet Explorer を使用する場合は、[Selenium](http://www.seleniumhq.org/) の[ダウンロードページ](http://www.seleniumhq.org/download/)から下記のいずれかをダウンロードし、IEDriverServer.exe を PATH の通ったディレクトリにコピーします。
    * [32 bit Windows IE](http://code.google.com/p/selenium/downloads/detail?name=IEDriverServer_Win32_2.38.0.zip)
    * [64 bit Windows IE](http://code.google.com/p/selenium/downloads/detail?name=IEDriverServer_x64_2.38.0.zip)

### テストの実行

コマンドプロンプトから `\work\r2` ディレクトリに移動して、それぞれ下記のコマンドによりテストを実行します。

1. 単体テスト

        > rake test:models

    現在、test/models 配下の単体テストにはアサーションが無いため、何も起こらない状況です。

2. 機能テスト

        > rake test:controllers

    現在、test/controllers 配下の機能テストにはアサーションが無いため、何も起こらない状況です。

3. 統合テスト

        > rake test:integration

4. 受け入れテスト

        > rake test:acceptance

    デフォルトでは、Firefox を起動してシナリオを流します。
    受け入れテスト中のブラウザのスクリーンショットが screenshot ディレクトリ配下に保存されます。

5. すべてのテストを一括実行

        > rake test

### テストカバレッジの確認

テストを実行すると、`\work\r2\coverage\index.html` にカバレッジレポートが作成されます。

### テスト実行の Tips

1. 特定の受け入れテストのみを指定してテストを実行するには

    例えば、test/acceptance/scenario_test.rb のみを実行したい場合は下記のようにテストを起動します。

        > rake test:acceptance TEST=test/acceptance/scenario_test

2. どのテストを実行中か、経過表示で確認するには

    下記のようにテストを起動すると、進捗表示が詳細モードになります。

        > rake test:acceptance TESTOPTS=-v
        Run options: -v --seed 2972

        # Running tests:

        MasterMaintenanceFlowsTest#test_list_companies = 13.44 s = .
        MasterMaintenanceFlowsTest#test_register_new_company_with_valid_company_information = 3.16 s = .
        ScenarioTest#test_scenario-1_of_sprint-2 = 105.82 s = .
        SigningFlowsTest#test_sign_in_as_existing_user_and_then_sign_out = 1.48 s = .
        SigningFlowsTest#test_sign_up_with_valid_user_information_and_then_sign_out = 2.97 s = .
        SigningFlowsTest#test_try_to_sign_in_with_unknown_userid = 0.78 s = .
        SigningFlowsTest#test_try_to_sign_up_with_ill-formed_userid = 2.27 s = .
        SigningFlowsTest#test_try_to_sign_up_with_userid_same_as_one_of_existing_user = 2.26 s = .
        SigningFlowsTest#test_try_to_sign_up_without_name = 2.13 s = .
        SigningFlowsTest#test_try_to_sign_up_without_userid = 2.10 s = .


        Finished tests in 136.412177s, 0.0733 tests/s, 0.6744 assertions/s.

        10 tests, 92 assertions, 0 failures, 0 errors, 0 skips

3. Internet Explorer を使った受け入れテストを実行するには

    `\work\r2\test\test_helper.rb` の 38 行目あたりにある

        Capybara.default_driver = :selenium_firefox

    行をコメントアウトして、その下にある

        #Capybara.default_driver = :selenium_ie

    行のコメントアウトを解除して `rake test:acceptance` を実行してください。
    ただ、Windows7 で Internet Explorer 9 が入っている環境で試してみたところ、たまにテストが失敗する場合があるようです。

### 受け入れテストの書き方

受け入れテストのサンプルとして、`test\acceptance\scenario_test.rb` の内容を解説します。

1. 受け入れテストクラスの定義開始

    ```ruby
    require 'test_helper'

    class ScenarioTest < AcceptanceTest
      fixtures :users, :companies, :enginestatuses, :businessstatuses
    ```
    受け入れテストクラスの基底クラスは `test\test_helper.rb` で定義している `AcceptanceTest` クラスを指定してください。
    `fixtures` の引数には、用意しているフィクスチャを全て指定してください。

2. 受け入れテストメソッドの定義開始

    ```ruby
    test "scenario-1 of sprint-2" do
    ```
    何のテストか分かるようにタイトルを付けます。

3. シナリオを Capybara の DSL で書き下す

    ```ruby
    # 1.1. サインインする
    sign_in "SG000001", "password"
    save_screenshot "scenario1-1_1.png"
    ```
    r2 のサインイン画面を表示し、社員コードとパスワードを入力してサインインします。
    サインイン後にメインメニューに遷移した画面をテストエビデンスとして scenario1-1\_1.png に保存します。
    `sign_in` メソッドは、Capybara の DSL ではなく、test/test_helper.rb の `AcceptanceTest` クラスに定義したメソッドです。

    ```ruby
    class AcceptanceTest < ActionDispatch::IntegrationTest
      include Capybara::DSL

    ...snip...
      private
      def visit_root
        visit root_path
        assert_equal new_user_session_path, current_path
      end

      def sign_in(userid, password)
        visit_root
        fill_in "user_userid", with: userid
        fill_in "user_password", with: password
        click_button "ログイン"
        assert_equal root_path, current_path
      end

    ...snip...
    end
    ```
    `sign_in` メソッドは内部で `visit_root` メソッドを呼び出して、r2 のルート URL にアクセスします。
    `visit_root` メソッド内の `visit` は、Capybara が提供するメソッドで、引数に指定した URL をブラウザにアクセスさせます。
    次の、`assert_equal` は、Rails のテストフレームワークが提供するアサーションです。
    Capybara が提供する `current_path` メソッドで、ブラウザが現在表示しているページの URL を取得し、それが予期したものであるかをテストしています。

    その後、`sign_in` メソッドでは、Capybara が提供する `fill_in` メソッドを使って、サインインページの社員コードとパスワードを入力します。
    `fill_in` メソッドの第一引数には、HTML の INPUT タグに付けた name や、対応する LABEL タグの内容、CSS の id などを指定し、対象とする入力要素を選択します。
    対象となる入力要素に `with:` 引数に指定した内容が入力されます。
    最後に Capybara の `click_button` メソッドにより、「ログイン」ボタンを押下しています。

    このように、Capybara が提供する DSL と、それを拡張するために定義した独自の DSL を使って、ブラウザを操作していきます。
    Capybara の DSL については、http://rubydoc.info/github/jnicklas/capybara/master/ を参照してください。

    あとは、HTML の SELECT を操作する `select ... from:`、HTML ページの構造を掘り進めるための `within`、CSS のセレクタ表記で HTML ページ内の要素を検索する `find` などを駆使して、シナリオを書き下していきます。

### ここまでのテスト環境の構築方法

1. Gemfile の変更

    test 環境で使用する gem を追加するため、下記を末尾に追記。

    ```ruby
    # Use Capybara and Selenium for acceptance test
    group :test do
      gem 'capybara'
      gem 'selenium-webdriver'
      gem 'database_cleaner'
      gem 'simplecov'
    end
    ```

2. Rakefile の変更

    受け入れテストのみを `rake test:acceptance` で実行できるようにするため、下記を末尾に追記。
    ```ruby
    task :test => "test:acceptance"

    namespace :test do
      Rake::TestTask.new(:acceptance => :prepare) do |t|
        t.libs << "test"
        t.pattern = "test/acceptance/**/*_test.rb"

        require 'rails/code_statistics'
        ::STATS_DIRECTORIES << ["Acceptance tests", "test/acceptance"]
        ::CodeStatistics::TEST_TYPES << "Acceptance tests"
      end
    end
    ```
    冒頭の task 行は、`rake test` ですべてのテストを実行する場合に、受け入れテストも流れるようにするための設定です。

    `require 'rails/code_statistics'` 以降の部分は、下記のように `rake stats` による LOC 表示に test/acceptance 配下の受け入れテストも含めるための設定です。
    ```
    % rake stats
    +----------------------+-------+-------+---------+---------+-----+-------+
    | Name                 | Lines |   LOC | Classes | Methods | M/C | LOC/M |
    +----------------------+-------+-------+---------+---------+-----+-------+
    | Controllers          |   725 |   484 |       9 |      74 |   8 |     4 |
    | Helpers              |    47 |    35 |       0 |       5 |   0 |     5 |
    | Models               |   230 |   139 |       9 |      22 |   2 |     4 |
    | Mailers              |     0 |     0 |       0 |       0 |   0 |     0 |
    | Javascripts          |    37 |     0 |       0 |       0 |   0 |     0 |
    | Libraries            |     0 |     0 |       0 |       0 |   0 |     0 |
    | Controller tests     |   357 |    21 |       7 |       0 |   0 |     0 |
    | Helper tests         |    28 |    21 |       7 |       0 |   0 |     0 |
    | Model tests          |    56 |    24 |       8 |       0 |   0 |     0 |
    | Mailer tests         |     0 |     0 |       0 |       0 |   0 |     0 |
    | Integration tests    |   202 |   156 |       2 |       3 |   1 |    50 |
    | Acceptance tests     |   444 |   303 |       3 |       0 |   0 |     0 |
    +----------------------+-------+-------+---------+---------+-----+-------+
    | Total                |  2126 |  1183 |      45 |     104 |   2 |     9 |
    +----------------------+-------+-------+---------+---------+-----+-------+
      Code LOC: 658     Test LOC: 525     Code to Test Ratio: 1:0.8
    ```

3. test/test\_helper.rb の変更

    * テストカバレッジを測定するため、simplecov の起動処理を追加

      ```ruby
      require "simplecov"
      SimpleCov.start "rails"
      ```

    * 受け入れテストの基底クラスとして AcceptanceTest を追加

      ```ruby
      require "capybara/rails"
      require "fileutils"

      class AcceptanceTest < ActionDispatch::IntegrationTest
        include Capybara::DSL
        include FileUtils

        SCREENSHOTS_DIR = "screenshot"

        self.use_transactional_fixtures = false

        setup do
          save_and_invalidate_proxy_settings

          Capybara.register_driver :selenium_firefox do |app|
            Capybara::Selenium::Driver.new(app, browser: :firefox)
          end
          Capybara.register_driver :selenium_ie do |app|
            Capybara::Selenium::Driver.new(app, browser: :internet_explorer)
          end
          #Capybara.default_driver = :rack_test
          #Capybara.default_driver = :selenium
          Capybara.default_driver = :selenium_firefox
          #Capybara.default_driver = :selenium_ie

          Capybara.default_wait_time = 60
          DatabaseCleaner.strategy = :transaction
        end

        teardown do
          #Capybara.reset!
          #Capybara.reset_sessions!
          #Capybara.use_default_driver
          DatabaseCleaner.clean

          restore_proxy_settings
        end

        private
        def visit_root
          visit root_path
          assert_equal new_user_session_path, current_path
        end

        def sign_in(userid, password)
          visit_root
          fill_in "user_userid", with: userid
          fill_in "user_password", with: password
          click_button "ログイン"
          assert_equal root_path, current_path
        end

        def sign_out
          click_link "サインアウト"
          assert_equal new_user_session_path, current_path
        end

        def save_screenshot(fname)
          unless Capybara.default_driver == :rack_test
            mkdir_p SCREENSHOTS_DIR
            super(File.join(SCREENSHOTS_DIR, fname))
          end
        end

        def nth_tag(tag, nth)
          find "#{tag}:nth-of-type(#{nth})"
        end

        def save_and_invalidate_proxy_settings
          @lower_http_proxy  = ENV.delete("http_proxy")
          @upper_http_proxy  = ENV.delete("HTTP_PROXY")
          @lower_https_proxy = ENV.delete("https_proxy")
          @upper_https_proxy = ENV.delete("HTTPS_PROXY")
        end

        def restore_proxy_settings
          @lower_http_proxy  and ENV["http_proxy"]  = @lower_http_proxy
          @upper_http_proxy  and ENV["HTTP_PROXY"]  = @upper_http_proxy
          @lower_https_proxy and ENV["https_proxy"] = @lower_https_proxy
          @upper_https_proxy and ENV["HTTPS_PROXY"] = @upper_https_proxy
        end
      end
      ```

### GitHub / Travis CI / Heroku を連携した回帰テストとデプロイの自動化

#### GitHub と Travis CI の連携

まず、Travis CI にサインアップして、GitHub アカウントとの連携を設定します。

1. [Travis CI](https://travis-ci.org/) サイトを開き、右上の Sign in with GitHub リンクからサインインします
    * 初回サインイン時は、GitHub アカウントに Travis CI 連携の許可設定を求められるので許可します

2. Travis CI 画面右上の GitHub ユーザ名をクリックして、アカウント設定画面を開きます

3. Repositories タブに GitHub リポジトリが表示されるので、CI したいリポジトリのスイッチを ON に設定します
    * スパナアイコンをクリックすると、該当する GitHub リポジトリ側の Service Hooks 設定画面が開くので、Travis フックを有効にします
    * Travis フックを有効にするには Travis CI アカウントの登録キーなどの入力が必要ですが、スパナアイコンから辿ると自動で入力された気がします

4. Profile タブで、locale: を「日本語」に設定すると、表示言語を日本語にできます。

#### リポジトリの設定

GitHub リポジトリに変更を push したタイミングで、Travis CI 上で実行する回帰テストの手順を設定します。
手順は、リポジトリのルートディレクトリに `.travis.yml` ファイルを新規作成して記述します。
まずは、下記内容の `.travis.yml` ファイルを作成してください。

```yaml
language: ruby

rvm:
  - 2.0.0

gemfile:
  - Gemfile

before_script:
  - export DISPLAY=:99.0
  - sh -e /etc/init.d/xvfb start

script:
  - bundle exec rake test:integration test:acceptance
```

* language

  Ruby のアプリケーションなので ruby と指定します。

* rvm

  回帰テストで使用する Ruby のバージョンを指定します。

* gemfile

  テスト前に bundle install するための Gemfile を指定します。

* before\_script

  回帰テスト前に実行するコマンドを指定します。
  上記内容は、受け入れテスト時に Travis CI 上で実際に Firefox を起動するための準備です。

* script

  回帰テストとして実行するコマンドを指定します。
  上記内容では、統合テストと受け入れテストを実行します。

この段階で、GitHub / Travis CI 連携のための設定が完了です。
https://travis-ci.org/yanoh/r2 を開いた状態で、`.travis.yml` ファイルを追加したブランチを GitHub に push すると、しばらくして Travis CI 画面で回帰テストの実行状態を確認できます。

#### Heroku アプリケーションの作成

[Heroku](https://heroku.com/) サイトにサインアップして、下記の手順でアプリケーションを作成します。
すみません。Linux 機で作業していたので、Windows での手順は試していません。。。

1. Heroku Toolbelt をインストールする

    ```
    % wget -qO- https://toolbelt.heroku.com/install.sh | sh
    ```

2. アプリケーションを作成する

    ```
    % cd r2
    % heroku apps:create r2-staging
    ```

3. PostgreSQL アドオンをインストールする

    ```
    % heroku addons:add heroku-postgresql:dev
    % heroku config | grep POSTGRESQL
    HEROKU_POSTGRESQL_ORANGE_URL: ...
    % heroku pg:promote HEROKU_POSTGRESQL_ORANGE_URL
    ```

この段階で、Heroku に push すれば手動デプロイできるはずですが、ネットワークの都合上試せませんでした。

#### Travis CI command line clients のインストール

`travis` gem で公開されているので、通常の gem install 手順でインストールできます。

```
% gem install travis
```

#### Travis CI から Heroku へのアプリケーション自動デプロイ設定

先ほど作成した `.travis.yml` ファイルの内容は、回帰テストのみを実行するものです。
回帰テストが成功した場合に、自動でステージング環境にデプロイするために、下記のように deploy セクションを `.travis.yml` に追記します。

```yaml
language: ruby

rvm:
  - 2.0.0

gemfile:
  - Gemfile

before_script:
  - export DISPLAY=:99.0
  - sh -e /etc/init.d/xvfb start

script:
  - bundle exec rake test:integration test:acceptance

deploy:
  provider: heroku
  api_key:
    secure: ...
  app:
    develop: r2-staging
  run:
    - rake db:schema:load
    - rake db:fixtures:load
```

* deploy.provider

  Heroku へデプロイするので heroku を指定します。

* api\_key.secure

  下記コマンドの出力結果をそのまま張り付けます。
  ```
  > travis encrypt $(heroku auth:token)
  ```

* deploy.app

  GitHub リポジトリのどのブランチを、Heroku のどのアプリケーションにデプロイするかを指定します。
  上記内容では、`develop` ブランチを http://r2-staging.herokuapp.com/ にデプロイします。

* run

  デプロイ時に Heroku で実行するコマンドを指定します。
  上記内容では、デプロイ時に常に rake db:schema:load db:fixtures:load を実行することになります。

この段階で、GitHub / Travis CI / Heroku 連携のための設定が完了です。
先ほどと同様に、https://travis-ci.org/yanoh/r2 を開いた状態で、`.travis.yml` ファイルを変更したブランチを GitHub に push すると、回帰テスト後に Heroku アプリケーションへのデプロイが動きます。

`.travis.yml` ファイルを手書きした後に気づいたのですが、travis コマンドでほぼ自動生成できるようです。。。
が、分量も少ないですし、設定内容を把握する意味でも手書きしてよかったです。

### 開発ワークフロー

さすがに本番環境へのデプロイまで自動化するのは危険なので、正常系のフローは下記のようになるのかな、と想像しています。

1. 開発環境でアプリを変更
2. 開発環境でテストを実行
3. テストが通れば develop ブランチにコミット
4. 変更がまとまったところで develop ブランチを GitHub に push
5. 自動で Travis CI による回帰テスト、ステージング環境へのデプロイ
6. ステージング環境で最終確認
7. develop ブランチへの変更を master にマージ
8. メンテナンスのスケジュールに従い、本番環境へ手動デプロイ

この文書での `.travis.yml` 設定では、develop ブランチから fork した feature ブランチでも、GitHub に push すると Travis CI による回帰テストが流れます。
なので、1 を feature ブランチで作業していれば、2 を Travis CI で実行できます。

回帰テスト成功後のステージング環境へのデプロイは develop ブランチに限定しているので、feature ブランチの Travis ジョブは回帰テスト完了で停止します。
