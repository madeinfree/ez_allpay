module EzAllpay
  module Helper
    module Keygen

      def create_calculate_check_mac_key
        add_check_key("HashKey=" + EzAllpay.api_hash_key + "&" + render_hash_params_to_request(EzAllpay.item_options) + "&HashIV=" + EzAllpay.api_hash_iv).upcase
      end

      def render_hash_params_to_request(key)
        result = key.to_a.sort.map do |key, value|
          "#{key}=#{value}"
        end
        result.join("&")
      end

      def add_check_key(key)
        render_key_to_md5(CGI::escape(key).downcase)
      end

      def render_key_to_md5(key)
        Digest::MD5.hexdigest(key)
      end

    end
  end
end