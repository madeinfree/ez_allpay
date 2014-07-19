require 'ez_allpay/generater/ez_allpay_generater'
module EzAllpay
  module EzAllpayFor

    include EzAllpay::Generater::EzAllpayGenerater

    def ez_allpay_for(record)
      initialize_generater(record)
    end

  end
end