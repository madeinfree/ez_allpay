# EzAllpay

=====
預計完成
=====
  * ☐ 自動串接歐付寶金流
    * ☐ 必須串接正式與測試網址
    * ✔ 1. 開發環境：http://vendor-stage.allpay.com.tw/Frame/Index @done (14-07-19 16:45)
    * ☐ 2. 正式環境：https://vendor.allpay.com.tw/
  * ☐ 線上環境區分（developer, production）
    * ☐ merchant_id, hash_key, hash_iv 依照環境分開
      * ☐ 預設好官方環境 merchant_id: 2000132,  hash_key: 5294y06JbISpM5x9, hash_iv: v77hoKGq4kWxNNIS
  * ☐ 使用者資料庫格式
  * ☐ 使用文件（Usage Document）
  * ☐ 開發者文件（Developer Document）

# 完成度
note: 此RubyGem目前為測試開發用大略完成約一半，目前是支援測試環境的狀態，尚未傳至RubyGem請先在git中下載，歡迎大家幫忙一起fork修改此專案，多給予PR。

請先從此git中下載：

    gem 'ez_allpay' :git => 'git://github.com/madeinfree/ez_allpay.git

執行安裝：

    $ bundle install

[x]：

    $ gem install ez_allpay [x]

## Usage

``` ruby
# 此檔案請新增在config/initializers/ez_allpay.rb
EzAllpay.setup do |allpay|
  if Rails.env.development?
    allpay.merchant_id = '2000132'
    allpay.hash_key    = '5294y06JbISpM5x9'
    allpay.hash_iv     = 'v77hoKGq4kWxNNIS'
  else
    allpay.merchant_id = "write your production merchant_id"
    allpay.hash_key    = "write your production hash_key"
    allpay.hash_iv     = "write your production hash_iv"
  end
end
```

``` ruby
# config/environments/development.rb
config.after_initialize do
  EzAllpay.integration_mode = :development
end

# config/environments/production.rb
config.after_initialize do
  EzAllpay.integration_mode = :production
end

```

## 開發者筆記

ez_allpay_for.rb「Usage」
``` ruby
# 此方法在 controller 中加入 helper_method :ez_allpay_for 即可在 view 中使用。
# record 傳入要傳送的商品值
# ex: @product = Product.find(1)
# <%= ez_allpay_for @product %>

ez_allpay_for(record) 呼叫方法
```

tag_creater.rb「建構表單方法」
``` ruby
# 此份檔案為建立基本表單方法
tag_form_create # 產生form表單基本元素並自動添加開發網址「開發、上線」
tag_params_adder # 建立form表單內部歐付寶需求規格標簽
tag_key_adder # 此方法會自動建立檢查字串 CheckMacValue
tag_adder # tag_params_adder 輔助執行方法
submit_tag_adder # 建立送出按鈕
```

ez_allpay/helper/keygen.rb「建立歐付寶CheckMacValue檢查字串」
``` ruby
create_calculate_check_mac_key #自動建立方法
render_hash_params_to_request #Hash轉換字串
add_check_key # 轉為unicode
render_key_to_md5 #轉為MD5
```

ez_allpay/generater/ez_allpay_generater.rb
``` ruby
initialize_generater # 初始化
create_action # 起始點
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/ez_allpay/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
