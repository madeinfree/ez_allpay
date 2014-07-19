#outerfile
require 'action_view'

#Version
require "ez_allpay/version"

#Helper
require "ez_allpay/helper/keygen"

#Resources
require "ez_allpay/util"
require "ez_allpay/tag_creater"
require "ez_allpay/ez_allpay_for"

#Generater
require "ez_allpay/generater/ez_allpay_generater"

module EzAllpay

  @api_base_url = "http://payment-stage.allpay.com.tw/Cashier/AioCheckOut"
  @api_hash_key = "5294y06JbISpM5x9"
  @api_hash_iv = "v77hoKGq4kWxNNIS"

  class << self
    attr_accessor :api_base_url, :api_hash_key, :api_hash_iv
  end

  mattr_accessor :item_options
  @@item_options = {}

end
