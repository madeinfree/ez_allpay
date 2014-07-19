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


Add this line to your application's Gemfile:

    gem 'ez_allpay'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ez_allpay

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/ez_allpay/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
