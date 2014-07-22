module EzAllpay
  module Factors
    module RecordsFactor

      def mutiple_records_init(records)
        records.each do |record|
          mutiple_records_maker(record, key, key_instead)
        end
      end

      def mutiple_records_maker(record, key, key_instead)
        if record.respond_to?('each')
          record.each do |record_key|
            if record_key.respond_to?(key_instead)
              case key
                when :MerchantTradeDate
                  EzAllpay.item_options[key] = record_key[key_instead].strftime("%Y/%m/%d %H:%M:%S")
                else
                  EzAllpay.item_options[key] = record_key[key_instead]
              end
            end
          end
        else
          if record.respond_to?(key_instead)
            case key
              when :MerchantTradeDate
                EzAllpay.item_options[key] = record[key_instead].strftime("%Y/%m/%d %H:%M:%S")
              else
                EzAllpay.item_options[key] = record[key_instead]
            end
          end
        end
      end

      def single_records_maker(records, key, key_instead)
        if records.respond_to?(key_instead)
          case key
            when :MerchantTradeDate
              EzAllpay.item_options[key] = records[key_instead].strftime("%Y/%m/%d %H:%M:%S")
            else
              EzAllpay.item_options[key] = records[key_instead]
          end
        end
      end

    end
  end
end