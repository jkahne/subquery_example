# README

This is the way we were trying yesterday, but it doesn't work


select vi.due_date, vi.name, sum(p.amount_cents) as payment_total, sum(li.amount_cents) as line_item_total
from vendor_invoices as vi
inner join vendor_payments as p on p.vendor_invoice_id = vi.id
inner join bill_line_items  as li on li.vendor_invoice_id = vi.id
group by 1,2
;


taking out the sum and group by, we can see why.  Every payment is matched to every line item

select vi.due_date, vi.name, (p.amount_cents) as payment_total, (li.amount_cents) as line_item_total
from vendor_invoices as vi
inner join vendor_payments as p on p.vendor_invoice_id = vi.id
inner join bill_line_items  as li on li.vendor_invoice_id = vi.id
;




this is the sql we need to do: 

select vi.*, payments.total  as payment_total, line_items.total as line_item_total
from vendor_invoices as vi
inner join
(
select vendor_invoice_id, sum(amount_cents) as total
from vendor_payments
group by vendor_invoice_id
) as payments on payments.vendor_invoice_id = vi.id

inner join
(
select vendor_invoice_id, sum(amount_cents) as total
from bill_line_items
group by vendor_invoice_id
) as line_items on line_items.vendor_invoice_id = vi.id
where  payments.total <> line_items.total;



