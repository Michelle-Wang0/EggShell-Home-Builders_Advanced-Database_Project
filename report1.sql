--SALES OVERVIEW BY CUSTOMER 
--This report helps us to see that for every customer, how many lots have been purchased, and how much money they spend on it.
SELECT
    customer.customer_id,
    customer.fname,
    customer.lname,
    COALESCE(SUM(sale.base_price + sale.lot_premium),0) AS total_spending,
    COALESCE(COUNT(sale.lot_lot_id),0)                   AS purchase_count
FROM
         customer
LEFT JOIN sale ON customer.customer_id = sale.customer_customer_id
GROUP BY
    customer.customer_id,
    customer.fname,
    customer.lname 
ORDER BY total_spending DESC, purchase_count  DESC;