class VendorInvoice < ApplicationRecord

  has_many :vendor_payments
  has_many :bill_line_items


  def self.doit
    #subqueries
    payments = VendorPayment.select("vendor_invoice_id, sum(amount_cents) as total").group(:vendor_invoice_id)
    line_items = BillLineItem.select("vendor_invoice_id, sum(amount_cents) as total").group(:vendor_invoice_id)
    
   result = VendorInvoice
      .select("vendor_invoices.*, payments.total as payment_total, line_items.total as line_item_total")
      .from("vendor_invoices left join (" + payments.to_sql + ") as payments on payments.vendor_invoice_id = vendor_invoices.id left join (" + line_items.to_sql + ") as line_items on line_items.vendor_invoice_id = vendor_invoices.id")
      .where("payments.total <> line_items.total")

    result.map{|row| "#{row.name}(id: #{row.id}), due on #{row.due_date}: #{row["payment_total"]} does not equal #{row["line_item_total"]}" }
  end
end
