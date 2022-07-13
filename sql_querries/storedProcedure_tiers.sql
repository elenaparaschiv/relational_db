/*
Create a stored procedure called “Get_Customer_Level”,
    > it will take the CustomerID as a parameter and return its level,
    To calculate the level it will calculate:
     the overall AOV(average order value) for all the orders,
     calculate the AOV of this customer and 
     check if the customer AOV > overall AOV 
        then it will return “Platinum” and
        if customer AOV >= 2x overall AOV it will return “Key Account”,
        otherwise it will return “Normal”.
*/

DELIMITER $$
CREATE PROCEDURE getCustomerLevel(
	IN _CustomerId_param INT
)
BEGIN

	SET @AOV_all = 
	(
        SELECT 
            Format(SUM(OrderDetails.Sale) / COUNT(Orders.POS_OrderKey),0) as aov_all
        FROM Customers
        LEFT JOIN Orders
        ON Customers.CustomerId = Orders.CustomerId
        LEFT JOIN OrderDetails
        ON Orders.POS_OrderKey = OrderDetails.POS_OrderKey
	); 
   

SELECT
	CustomerId,
	customer_orders,
    avg_sale_cust_order,
    CASE
       WHEN avg_sale_cust_order >=(@AOV_all * 2) THEN "Key Account"
       WHEN  avg_sale_cust_order > @AOV_all THEN "Platinum"
       ELSE "Normal"
    END as Customer_Lvl
	FROM(
        SELECT
            CustomerId,
            customer_orders,
            FORMAT(customer_sales_val / customer_orders ,0) as avg_sale_cust_order
        FROM
        (
            SELECT 
                DISTINCT
                Customers.CustomerId,
                nOrders as customer_orders, # this was tricky if I did window same like below I would get   #more orders.How could I have done a window instead
                SUM(OrderDetails.Sale)  OVER (PARTITION BY Customers.CustomerId ) as customer_sales_val
            FROM Customers
            LEFT JOIN Orders
            ON Customers.CustomerId = Orders.CustomerId
            LEFT JOIN OrderDetails
            ON Orders.POS_OrderKey = OrderDetails.POS_OrderKey
			WHERE Customers.CustomerId = _CustomerId_param
        ) as subq
) as subq2;

END $$

DELIMITER ;



// Test it 
CALL getCustomerLevel(3)