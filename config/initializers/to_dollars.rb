# Extend TrueClass with to_bool
class BigDecimal
  include ActionView::Helpers::NumberHelper
  def to_dollars
    number_to_currency(self, unit: '$')
  end
end
