class Cart
  include MongoMapper::Document

  key :email, String
  key :accounts_payable_email, String
  key :po_number, String
  key :we_accept_po, String

  key :shipping_first_name, String
  key :shipping_last_name, String
  key :shipping_company, String
  key :shipping_address1, String
  key :shipping_address2, String
  key :shipping_city, String
  key :shipping_province, String
  key :shipping_zip, String
  key :shipping_country, String
  key :shipping_phone, String

  key :shipping_method, String, :default => "Regular"

  key :billing_email, String
  key :billing_first_name, String
  key :billing_last_name, String
  key :billing_company, String
  key :billing_address1, String
  key :billing_address2, String
  key :billing_city, String
  key :billing_province, String
  key :billing_zip, String
  key :billing_country, String
  key :billing_phone, String

  key :subtotal, Float, :default => 0
  key :shipping, Float, :default => 9.40
  key :gst, Float, :default => 0
  key :total, Float, :default => 0

  key :ordering_note, String
  key :discount_code, String
  key :discount_amount, Float, :default => 0

  key :ip, String
  key :user_agent, String
  key :referer, String

  many :items

  def add(variant_id, qty)

    puts "variant_id: #{variant_id}"

    unless variant_id.nil?

      if qty > 0

        product = Product.where(:shopify_variant_id => variant_id).fields(:title, :shopify_variant_id, :shopify_product_id, :price, :local_inv,:supplier_inv, :shopify_handle, :ebay_inv, :sku, :supplier).first

        unless product.nil?

          item = self.items.select{|a| a.variant_id == variant_id}.first

          if item
            qty = check_available(variant_id, item.qty + qty)

            if qty > 0
              item.qty = qty
              item.save
            end

          else
            item = Item.new
            item.variant_id = product.shopify_variant_id.to_i
            item.product_id = product.shopify_product_id.to_i

            item.title = product.title
            item.price = product.price
            item.img_url = product.images.first.src rescue "https://placeholdit.imgix.net/~text?txtsize=13&txt=image%20coming%20soon&w=100&h=100"
            item.local_inv = product.local_inv
            item.supplier_inv = product.supplier_inv
            item.handle = product.shopify_handle
            item.qty = check_available(variant_id, qty)

            if item.qty > 0
              self.items << item
            end

          end

        end

      end

    end

    self.save
  end

  def order_subtotal
    return (self.items.sum{|a| a.price * a.qty})
  end

  def calculate_discount

    discount = 0

    unless( self.discount_code.nil? )

      code = nil

      codes = Store.all().first.discountcodes

      codes.each do |c|
        if c.discount_code == self.discount_code
          code = c
        end
      end

      puts code.inspect

      unless code.nil?
        if code.percent_value > 0
          discount = ( order_subtotal * (code.percent_value / 100) )
        else
          discount = code.dollar_value
        end

        if( order_subtotal - discount < 0 )
          discount = order_subtotal
        end
      end


    end

    return discount
  end


  def shipping_price
    shipping_price = 0

    case self.shipping_method
    when "Express"
      if self.order_subtotal > 150
        shipping_price = 4.0
      else
        shipping_price = 9.40
      end
    when "Regular"
      if self.order_subtotal > 150
        shipping_price = 0
      else
        shipping_price = 7.20
      end
    when "Pickup"
      shipping_price = 0
    else
      shipping_price = 999
    end

    return shipping_price

  end

  def order_total
    return ((self.items.sum{|a| a.price * a.qty} - self.discount_amount)+ self.shipping_price)
  end

  def update_item(variant_id, qty)

    qty = qty.to_i
    qty = check_available(variant_id, qty)

    if qty <= 0
      remove_item(variant_id)
    else
      item = self.items.select{|a| a.variant_id == variant_id}.first

      if item
        item.qty = qty
        item.save
      else
        add(variant_id, qty)
      end

    end

  end

  def remove_item(variant_id)
    item = self.items.select{|a| a.variant_id == variant_id}.first
    self.items.delete(item)
    self.save
  end

  def empty_cart()
    self.items.each do | item |
      self.items.delete(item)
    end
    self.save
  end

  def get_item_qty(variant_id)
    item = self.items.select{|a| a.variant_id == variant_id}.first

    unless item.nil?
      return item.qty
    end

    return nil

  end

  def check_available(variant_id, qty)

    products = Product.where(:shopify_variant_id => variant_id).fields(:local_inv,:supplier_inv).first

    unless products.nil?
      total_items = products.supplier_inv.to_i + products.local_inv.to_i

      if qty.to_i > total_items
        qty = total_items
      end

    end

    if qty < 0
      qty = 0
    end

    return qty

  end
  timestamps!

  before_save :update_totals


  private
  def update_totals
    self.subtotal = self.order_subtotal
    self.discount_amount = self.calculate_discount
    self.shipping = self.shipping_price
    self.total = self.order_total
    self.gst = (self.order_total * (1/11.0)).round(2)
  end
end


class Item
  include MongoMapper::EmbeddedDocument

  key :variant_id, Integer
  key :product_id, Integer

  key :local_inv, Integer
  key :supplier_inv, Integer

  key :backordered, Boolean

  key :title, String
  key :name, String
  key :sku, String
  key :handle, String

  key :img_url, String

  key :qty, Integer
  key :price, Float

  timestamps!
end

class ChirpyOrder



end