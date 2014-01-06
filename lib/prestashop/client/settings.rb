module Prestashop
  module Client    
    class Settings
      attr_accessor :country_iso_code, :lang_iso_code, :supplier, :import_enabled, :update_enabled, :update_price, :update_stock, :deactivate,
                    :product_active, :product_available_for_order, :product_show_price, :vat_enabled, :available_now, :available_later, :delimiter, :html_enabled

      def initialize args = {}
        @country_iso_code   = args.fetch(:country_iso_code, 'CZ')
        @lang_iso_code      = args.fetch(:lang_iso_code, 'cs')
        @supplier           = args.fetch(:supplier)
        @import_enabled     = args.fetch(:import_enabled, false)
        @update_enabled     = args.fetch(:update_enabled, false)
        @update_price       = args.fetch(:update_price, false)
        @update_stock       = args.fetch(:update_stock, false)
        @deactivate         = args.fetch(:deactivate, false)
        @product_active     = args.fetch(:product_active, false)
        @product_available_for_order = args.fetch(:product_available_for_order, false)
        @product_show_price = args.fetch(:product_show_price, false)
        @vat_enabled        = args.fetch(:vat_enabled, false)
        @available_now      = args.fetch(:available_now, 'Available now')
        @available_later    = args.fetch(:available_later, 'Available later')
        @delimiter          = args.fetch(:delimiter, '||')
        @html_enabled       = args.fetch(:html_enabled, false)
      end

      def id_country
        @id_country ||= Mapper::Country.find_by_iso_code(country_iso_code)
      end

      def id_language
        @id_language ||= Mapper::Language.find_by_iso_code(lang_iso_code)
      end

      def id_supplier
        @id_supplier ||= Mapper::Supplier.new(name: supplier).find_or_create
      end

      def taxes
        @taxes ||= Mapper::Tax.get_by_id_country(id_country)
      end

      def manufacturers_cache
        @manufacturers_cache ||= Mapper::Manufacturer.cache
      end

      def clear_manufacturers_cache
        @manufacturers_cache = nil
      end

      def categories_cache
        @categories_cache ||= Mapper::Category.cache
      end

      def clear_categories_cache
        @categories_cache = nil
      end

      def features_cache
        @features_cache ||= Mapper::ProductFeature.cache
      end

      def clear_features_cache
        @features_cache = nil
      end
      
      def feature_values_cache
        @feature_values_cache ||= Mapper::ProductFeatureValue.cache
      end

      def clear_feature_values_cache
        @feature_values_cache = nil
      end

      def options_cache
        @options_cache ||= Mapper::ProductOption.cache
      end

      def clear_options_cache
        @options_cache = nil
      end

      def option_values_cache
        @option_values_cache ||= Mapper::ProductOptionValue.cache
      end

      def clear_option_values_cache
        @option_values_cache = nil
      end
    end
  end
end