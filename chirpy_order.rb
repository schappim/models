class ChirpyOrder
  include MongoMapper::Document

  before_create do
    self.id ||= MongoSequence[:chirpy_order].next # for id's unique among Peregrines
  end

  def unpaid?
    if self.financial_status != 'paid'
      return true
    end
  end

  def paid?
    if self.financial_status == 'paid'
      return true
    end
  end

  #def fulfilled?
  #  if self.fulfillment_status == "fullfilled" || self.fulfillment_status == "fulfilled"
  #    return true
  #  end
  #end

  def fulfilled?
    self.chirpy_order_line_items.select{|line| line.fulfillable_quantity > 0}.length < 1
  end

  def name
    if self.id2.nil?
      return 'X'
    end
    return self.id2
  end

  def parts_backordered?
    self.chirpy_order_line_items.select{|line| line.backordered == true}.length > 0
  end

  key :email, String
  key :accounts_payable_email, String
  key :po_number, String
  key :we_accept_po, String
  key :cando, Boolean
  key :status, String, :default => 'open' #(open, closed, cancelled)

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

  key :dymo_shipping_label, String

  key :shipping_method, String

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
  key :ordering_note_seen, Integer, :default => 0

  key :discount_code, String
  key :discount_amount, Float, :default => 0

  key :name, String
  key :shopify_id, Integer
  key :fulfillment_status, String # (fulfilled, partial, null)
  key :tracking, String
  key :token, String
  key :gateway_info, String

  key :payment_method, String
  key :financial_status, String
  key :payment_date, Time

  # financial_status possible values:
  # pending
  # authorized
  # paid
  # partially_paid
  # refunded
  # partially_refunded
  # voided

  many :chirpy_order_line_items
  many :chirpy_fulfillments
  many :chirpy_order_events

  auto_increment!
  timestamps!
end


class ChirpyOrderEvent
  include MongoMapper::EmbeddedDocument

  key :title, String
  key :message, String
  key :user, String
  key :img, String # Image of the user or service creating the event
  key :icon, String # Action Icon - E.g. fulfillment or refund.
  key :internal, Boolean # For events which the customer doesn't need to see.

  timestamps!

end

class ChirpyOrderLineItem
  include MongoMapper::EmbeddedDocument

  key :local_inv_at_time_of_order, Integer
  key :supplier_inv_at_time_of_order, Integer
  key :backordered, Boolean

  key :title, String
  key :name, String
  key :sku, String
  key :img, String
  key :handle, String
  key :ordering_note, String

  key :prepped, Boolean
  key :prepped_by, String
  key :prepped_by_img, String
  key :prepped_qty, Integer
  key :prep_bin, String

  key :variant_title, String
  key :vendor, String

  key :supplier_order_number, String

  key :quantity, Integer
  key :fulfillable_quantity, Integer
  key :fulfilled, Boolean

  key :price, Float
  key :grams, Integer

  key :requires_shipping, Boolean
  key :gift_card, Boolean

  timestamps!
end

class ChirpyFulfillment
  include MongoMapper::EmbeddedDocument

  key :tracking_company, String
  key :tracking_numbers, Array
  key :fulfilled_by, String
  key :fulfilled_by_img, String

  many :chirpy_fulfillment_line_items

  timestamps!
end

class ChirpyFulfillmentLineItem
  include MongoMapper::EmbeddedDocument

  key :title, String
  key :name, String
  key :img, String
  key :handle, String
  key :sku, String
  key :quantity, String

  timestamps!
end


class ChirpyTag
  include MongoMapper::Document

  key :tag, String
  key :tag_type, String
  key :value, String
  key :link, String
  key :command, String

  timestamps!
end
