module EzAllpay
  module Generater
    module EzAllpayGenerater

      cattr_accessor :options
      mattr_accessor :initialize_generater

      include ::EzAllpay::TagCreater

      def initialize_generater(record)
        ::EzAllpay.item_options = record
        create_action(::EzAllpay.item_options)
      end

      def create_action(options)
        form_body = tag_form_create
        form_tags = tag_params_adder(options)
        form_key_tag = tag_key_adder
        (form_body + form_tags.join("") + form_key_tag + submit_tag_adder).html_safe
      end

    end
  end
end