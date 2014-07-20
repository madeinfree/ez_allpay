module EzAllpay
  module EzAllpayFor

    include EzAllpay::TagCreater

    mattr_accessor :record_options
    @@record_options = {}

    mattr_accessor :button_value
    mattr_accessor :button_style

    def ez_allpay_for(record, default_settings = {})
      button_settings(default_settings)
      
      EzAllpay::EzAllpayFor.record_options = record
      EzAllpay.item_options[:MerchantID] = EzAllpay.merchant_id
      EzAllpay.item_options[:ReturnURL] = EzAllpay.return_url

      yield

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

    def attr_instead(set_options)
      set_options.each do |key, key_instead|
        case key
          when :MerchantTradeDate
            EzAllpay.item_options[key] = EzAllpay::EzAllpayFor.record_options[key_instead].strftime("%Y/%m/%d %H:%M:%S")
          when :PaymentType
            EzAllpay.item_options[key] = "aio"
          when :ChoosePayment
            EzAllpay.item_options[key] = "CVS"
          else
            case key_instead
              when key_instead.nil?
                EzAllpay.item_options[key] = ""
              else
                EzAllpay.item_options[key] = EzAllpay::EzAllpayFor.record_options[key_instead]
            end
        end
      end
    end

  end
end

ActionView::Base.send :include, EzAllpay::EzAllpayFor