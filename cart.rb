
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

  key :shipping_method, String, :default => "Express"

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

  many :items

  def add(variant_id, qty)

    puts "variant_id: #{variant_id}"

    unless variant_id.nil?

      product = Product.where(:shopify_variant_id => variant_id).fields(:title, :shopify_variant_id, :shopify_product_id, :price, :local_inv,:supplier_inv, :shopify_handle, :ebay_inv, :sku, :supplier).first
      puts product.inspect

      puts variant_id.inspect

      unless product.nil?

        item = self.items.select{|a| a.variant_id == variant_id}.first

        if item
          item.qty = item.qty + qty
          item.save
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
          item.qty = qty

          self.items << item
        end

      end

    end

    self.save
  end

  def order_subtotal
    return (self.items.sum{|a| a.price * a.qty})
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
    return (self.items.sum{|a| a.price * a.qty} + self.shipping_price)
  end

  def update_item(variant_id, qty)
    item = self.items.select{|a| a.variant_id == variant_id}.first
    item.qty = qty
    item.save
  end

  def remove_item(variant_id)
    item = self.items.select{|a| a.variant_id == variant_id}.first
    self.items.delete(item)
    self.save
  end

  timestamps!

  before_save :update_totals


  private
  def update_totals
    self.subtotal = self.order_subtotal
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
