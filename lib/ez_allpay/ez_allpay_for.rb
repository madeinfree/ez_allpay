module EzAllpay
  module EzAllpayFor

    include EzAllpay::TagCreater
    include EzAllpay::Factors::RecordsFactor

    # 全域變數 record_options
    # 預設為 {}
    # 如有修改名稱，請將其他位置一併修改。
    # ..
    ###
    mattr_accessor :record_options
    @@record_options = {}

    # 設定按鈕文字 button_value
    # ..
    ###
    mattr_accessor :button_value

    # 設定按鈕樣式 button_style
    # ..
    ###
    mattr_accessor :button_style

    # view 呼叫方法 ez_allpay_for
    #
    # 支援雙層資料表結構，請將 attr_instead 後之 hash key 正確對應欄位名稱，
    # 例如：如果訂單編號是 order_no，請在 :MerchantTradeNo => :order_no，
    # 務必檢查對應欄位 model 的正確性，確定有欄位，如果找不到則「報錯」。
    #
    # 此用法為製作一個表單，跟有些金流的串接方式較為不同，此為前往安全官網進行訂單選項，
    # 使用此方法不需要製作 submit 表單送出按鈕，只需提供 setting 則會自動更改，預設為「確認」
    #
    # ex:
    #
    # example[1]
    # <%= ez_allpay_for @order, :setting => { :value => "付款", :css => "btn btn-danger" } do %>
    # <% attr_instead :MerchantTradeNo => :order_no %> # 廠商交易編號
    # <% attr_instead :MerchantTradeDate => :created_at%> # 廠商交易時間
    # <% attr_instead :PaymentType => "aio" %> # 交易類型, 預設為aio不更改
    # <% attr_instead :ChoosePayment => "SVC" %> #交易方式
    # <% attr_instead :TotalAmount => :price %> # 交易金額
    # <% attr_instead :TradeDesc => :description %> # 交易描述
    # <% attr_instead :ItemName => :name %> # 商品名稱
    # <% end %>
    # 
    # example[2]
    # <%= ez_allpay_for [@order,@order_items], :setting => { :value => "付款", :css => "btn btn-danger" } do %>
    # <% attr_instead :MerchantTradeNo => :order_no %> # 廠商交易編號
    # <% attr_instead :MerchantTradeDate => :created_at%> # 廠商交易時間
    # <% attr_instead :PaymentType => "aio" %> # 交易類型, 預設為aio不更改
    # <% attr_instead :ChoosePayment => "SVC" %> #交易方式
    # <% attr_instead :TotalAmount => :price %> # 交易金額
    # <% attr_instead :TradeDesc => :description %> # 交易描述
    # <% attr_instead :ItemName => :name %> # 商品名稱
    # <% end %>
    # ..
    ###
    def ez_allpay_for(records, default_settings = {})
      button_settings(default_settings)
      yield
      EzAllpay.item_options[:MerchantID] = EzAllpay.merchant_id
      EzAllpay.item_options[:ReturnURL] = EzAllpay.return_url
      EzAllpay.item_options[:ChoosePayment] = EzAllpay.choose_payment
      add_record_to_item_options(records)
      create_action(EzAllpay.item_options)
    end

    # 自動生成表單方法 create_action
    #
    # 此方法將自動生成一個隱藏表單，並且提供一個 submit 送出按鈕
    # ..
    ###
    def create_action(options)
      form_body = tag_form_create
      form_tags = tag_params_adder(options)
      form_key_tag = tag_key_adder
      (form_body + form_tags.join("") + form_key_tag + submit_tag_adder).html_safe
    end

    # 按鈕選項樣式、文字設定 button_settings
    # ex:
    #
    # <%= ez_allpay_for @order, :setting => { :value => "付款", :css => "btn btn-danger" } do %>
    # ..
    ###
    def button_settings(settings)
      @@button_value = settings[:setting][:value]
      @@button_style = settings[:setting][:css]
    end
    
    # 將 item_options 取代為 model record value
    # 
    # 此方法依照使用者指定的替代變數後，記錄在 EzAllpay.item_options 中，再由尋找 EzAllpay.item_options 中的 key
    # 來尋找在records資料中是否有相同的關鍵名稱，如有對應，則將 item_options[key] 替代為 records[key]。
    # 
    # 此方法會判斷是否為多層資料結構，如果為多層資料結構(Array)，則會自動核對資料欄位與使用者替代關鍵名稱，也可以直接使用
    # 單一資料結構的方式來產生
    #
    # mutiple_records_init 為拆解多層資料結構 -> factors/records_factor.rb
    #
    # single_records_maker 則為單資料結構 -> factors/records_factor.rb
    # ..
    ###
    def add_record_to_item_options(records)
      EzAllpay.item_options.each do |key, key_instead|
        if records.kind_of?(Array)
          mutiple_records_init(records)
        else
          single_records_maker(records, key, key_instead)
        end
      end
    end

    # 預設代替(查找)用的相對變數名稱 attr_instead
    # ex:
    #
    # EzAllpay.item_options[:MerchantTradeNo] = :token
    # ..
    ###
    def attr_instead(set_options)
      set_options.each do |key, key_instead|
          EzAllpay.item_options[key] = key_instead
      end
    end

  end
end

ActionView::Base.send :include, EzAllpay::EzAllpayFor