module MTL
  module Forms
    class MTLRequestForm < FillablePDF
      FORMS_PATH = "public/forms/mtl"
      BLANK = ""

      def fill_with(data)
        data.each do |k,v|
          Rails.logger.debug "Filling field #{k} (#{field_map[k]}) with '#{v}'"
          set_field mf(k), v
        end
        self
      end

      private
      def mf(f) = fn(field_map[f])
      def fn(fn='') = "topmostSubform[0].Page1[0]" + fn
    end
  end
end
