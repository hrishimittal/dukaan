class Basket
  # All prices are in pence/cents for avoiding rounding errors.
  CATALOG = [
    {
      name:"Jeans",
      code: :J01,
      price: 3295,
      promotion: ->(units){units - (units/2)/2.0 }
    },
    {
      name:"Blouse",
      code: :B01,
      price: 2495
    },
    {
      name:"Socks",
      code: :S01,
      price: 795
    }
  ]

  def initialize
    @items = Hash.new(0)
    @total = 0
  end

  def add(product_code)
    if product = find_product_in_catalog(product_code)
      @items[product_code] += 1
    end
  end

  def total
    items_total = calculate_items_total
    convert_to_amount(items_total + calculate_delivery_charges(items_total))
  end

  private
    def calculate_items_total
      CATALOG.map{|p| product_total(p[:code], @items[p[:code]]) }.inject(:+)
    end

    def product_total(product_code, units)
      price = find_product_in_catalog(product_code)[:price]
      price * apply_promotion(product_code, units)
    end

    def apply_promotion(product_code, units)
      if promotion = find_product_in_catalog(product_code)[:promotion]
        promotion.call(units)
      else
        units
      end
    end

    def find_product_in_catalog(product_code)
      CATALOG.find{|p| p[:code] == product_code }
    end

    def calculate_delivery_charges(basket_total)
      if basket_total < 5000
        495
      elsif basket_total < 9000
        295
      else
        0
      end
    end

    def convert_to_amount(cents)
      cents.floor/100.0
    end
end
