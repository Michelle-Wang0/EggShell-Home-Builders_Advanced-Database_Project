--2024 COMMISSION BY STAFF
--This reports help us to see the commissioner each staff take from their 2024 sales, assuming the commission rate to be 1%
SELECT
    s.staff_id,
    s.fname AS staff_first_name,
    s.lname AS staff_last_name,
    COALESCE(SUM(sa.base_price + sa.lot_premium),0) AS total_revenue,
    COALESCE(SUM(sa.base_price + sa.lot_premium),0) * 0.01 AS commission
FROM
    staff s
LEFT JOIN
    sale sa ON s.staff_id = sa.staff_staff_id
WHERE
    EXTRACT(YEAR FROM sa."date") = 2024
GROUP BY
    s.staff_id, s.fname, s.lname
ORDER BY commission DESC;
