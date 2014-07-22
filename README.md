# EzAllpay

Add this line to your application's Gemfile:

    gem 'ez_allpay'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ez_allpay

## Usage

```ruby
# config/initializers/ez_allpay.rb
EzAllpay.setup do |allpay|
  if Rails.env.development?
    allpay.merchant_id = '2000132'
    allpay.hash_key    = '5294y06JbISpM5x9'
    allpay.hash_iv     = 'v77hoKGq4kWxNNIS'
    allpay.return_url = 'write your production return_url'
  else
    allpay.merchant_id = 'write your production merchant_id'
    allpay.hash_key    = 'write your production hash_key'
    allpay.hash_iv     = 'write your production hash_iv'
    allpay.return_url = 'write your production return_url'
  end
end
```

```ruby
# config/environments/development.rb
config.after_initialize do
  EzAllpay.integration_mode = :development
end

# config/environments/production.rb
config.after_initialize do
  EzAllpay.integration_mode = :production
end
```

```ruby
# example
<%= ez_allpay_for @product, :setting => { :value => "付款", :css => "btn btn-danger" } do %>
  <% attr_instead :MerchantTradeNo => :bill_no %> # 廠商交易編號
  <% attr_instead :MerchantTradeDate => :created_at%> # 廠商交易時間
  <% attr_instead :PaymentType => "aio" %> # 交易類型, 預設為aio不更改
  <% attr_instead :ChoosePayment => "SVC" %> #交易方式
  <% attr_instead :TotalAmount => :price %> # 交易金額
  <% attr_instead :TradeDesc => :description %> # 交易描述
  <% attr_instead :ItemName => :name %> # 商品名稱
<% end %>
  
  #額外可選[option]#
  #<% attr_instead :ClientBackURL => "" %> # Client 端返回廠商網址
  #<% attr_instead :ItemURL => "" %> #商品銷售網址
  #<% attr_instead :Remark => "" %> # 備註欄位，請放空
  #<% attr_instead :ChooseSubPayment => "" %> # 選擇預設付款子項目
  #<% attr_instead :OrderResultURL => "" %> #Client 端回傳付款結果網址
  #<% attr_instead :Desc_1 => :item_desc_1 %> # 交易描述 1
  #<% attr_instead :Desc_2 => :item_desc_2 %> # 交易描述 2
  #<% attr_instead :Desc_3 => :item_desc_3 %> # 交易描述 3
  #<% attr_instead :Desc_4 => :item_desc_4 %> # 交易描述 4
  #<% attr_instead :PaymentInfoURL => "" %> # Server 端回傳付款相關資訊
  #<% attr_instead :ClientRedirectURL => :item_desc_4 %> # Client 端回傳付款相關資訊
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/ez_allpay/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request