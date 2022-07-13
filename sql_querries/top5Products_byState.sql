
-- We want to see the 5 most profitable products in a specific state across all years of activity

-- 7. Create a function that takes a state and returns 
-- what’s the 5 most profitable products in a specific state across all years.

-- ===== To call it: ====
-- CALL mostProfitableProdState(“Tennessee”)


DELIMITER $$

CREATE PROCEDURE mostProfitableProdState(
	IN _StateName VARCHAR(100)
)
BEGIN 
    SELECT
        ProductName,
        yearo,
        SUM(Profit) as sum_profit
    FROM
    (
        SELECT
            Product.ProductName,
            Year(Orders.ShipDate) AS yearo,
            OrderDetails.Profit
        FROM
        State
        LEFT JOIN City
            ON State.StateId = City.StateId
        LEFT JOIN Customer
            ON Customer.CityId = City.CityId
        LEFT JOIN Orders 
            ON Customer.CustomerId = Orders.CustomerId
        LEFT JOIN OrderDetails
            ON Orders.POS_OrderKey = OrderDetails.POS_OrderKey
        LEFT JOIN Product
            ON OrderDetails.ProductId = Product.ProductId
        WHERE State.StateName = _StateName
    ) as subq
    GROUP BY 1,2
    ORDER BY sum_profit desc
    LIMIT 5;

END
