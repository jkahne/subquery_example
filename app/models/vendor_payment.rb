class VendorPayment < ApplicationRecord
  belongs_to :vendor_invoice
end
