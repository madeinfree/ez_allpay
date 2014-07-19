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

  autoload :Keygen, "ez_allpay/helper/keygen"

  mattr_accessor :merchant_id
  mattr_accessor :hash_key 
  mattr_accessor :hash_iv

  @api_base_url = "http://payment-stage.allpay.com.tw/Cashier/AioCheckOut"

  class << self
    attr_accessor :api_base_url, :integration_mode
  end

  mattr_accessor :item_options
  @@item_options = {}

  def self.setup
    yield(self)
  end

end
