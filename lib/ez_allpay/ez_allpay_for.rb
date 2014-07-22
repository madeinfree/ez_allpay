module EzAllpay
  module EzAllpayFor

    include EzAllpay::TagCreater
    include EzAllpay::Factors::RecordsFactor

    mattr_accessor :record_options
    @@record_options = {}

    mattr_accessor :button_value
    mattr_accessor :button_style

    def ez_allpay_for(records, default_settings = {})
      button_settings(default_settings)
      
      #EzAllpay::EzAllpayFor.record_options = record

      yield

      EzAllpay.item_options[:MerchantID] = EzAllpay.merchant_id
      EzAllpay.item_options[:ReturnURL] = EzAllpay.return_url
      EzAllpay.item_options[:ChoosePayment] = EzAllpay.choose_payment

      add_record_to_item_options(records)

      create_action(EzAllpay.item_options)
    end

    def create_action(options)
      form_body = tag_form_create
      form_tags = tag_params_adder(options)
      form_key_tag = tag_key_adder
      (form_body + form_tags.join("") + form_key_tag + submit_tag_adder).html_safe
    end

    def button_settings(settings)
      @@button_value = settings[:setting][:value]
      @@button_style = settings[:setting][:css]
    end
    
    # 將 item_options 取代為 model record value
    def add_record_to_item_options(records)
      EzAllpay.item_options.each do |key, key_instead|
        if records.kind_of?(Array)
          mutiple_records_init(records)
        else
          single_records_maker(records, key, key_instead)
        end
      end
    end

    # 預設代替(查找)用的相對變數名稱
    # ex:
    #
    # EzAllpay.item_options[:MerchantTradeNo] = :token
    # ..
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