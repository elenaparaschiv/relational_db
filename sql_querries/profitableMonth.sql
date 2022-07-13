-- 9.Create a function that returns what was the most profitable month in each year

CREATE PROCEDURE mostProfitable_monthInYear()
BEGIN
    SELECT
        yearo,
        montho,
        profito
    FROM
    (
    SELECT
        yearo,
        montho,
        profito,
        RANK() OVER(PARTITION by yearo ORDER BY profito desc) ranko
    FROM
    ( 
        SELECT
        YEAR(Orders.OrderDate) as yearo,
        MONTH(Orders.OrderDate) as montho,
        SUM(OrderDetails.Profit) as profito
    FROM Orders
    LEFT JOIN	OrderDetails
        ON Orders.POS_OrderKey = OrderDetails.POS_OrderKey
    GROUP BY 1,2
    )subq1
    ) subq2
    WHERE ranko = 1; -- return the most profitable

END
