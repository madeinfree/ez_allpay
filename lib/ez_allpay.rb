#Outerfile
require 'action_view'

#Version
require "ez_allpay/version"

#Helper
require "ez_allpay/helper/keygen"

#Factors
require "ez_allpay/factors/records_factor"

#Resources
require "ez_allpay/tag_creater"
require "ez_allpay/ez_allpay_for"

module EzAllpay

  #
  mattr_accessor :service_url
  mattr_accessor :merchant_id
  mattr_accessor :hash_key 
  mattr_accessor :hash_iv
  mattr_accessor :return_url
  mattr_accessor :choose_payment

  #
  mattr_accessor :item_options
  @@item_options = {}

  class << self
    attr_accessor :integration_mode
  end

  def self.service_url
    mode = EzAllpay.integration_mode
    case mode
      when :development
        "http://payment-stage.allpay.com.tw/Cashier/AioCheckOut"
      when :production
        "https://payment.allpay.com.tw/Cashier/AioCheckOut"
      else
        raise StandardError, "Integration mode set to an invalid value: #{mode}"
    end
  end

  def self.setup
    yield(self)
  end

end