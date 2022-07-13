-- 13.For each product category as a parameter, 
-- the company wants to know what is the total profit per segments.

-- 
-- CALL totalProfitPerSegment()

DELIMITER $$
CREATE PROCEDURE totalProfitPerSegment()
BEGIN
    SELECT
        ProductCategory.ProductCategoryName,
        CustomerSegment.CustomerSegmentName,
        SUM(OrderDetails.Profit) as sum_profit
    FROM ProductCategory
    LEFT JOIN ProductSubcategory
        ON ProductCategory.ProductCategoryId = ProductSubcategory.ProductCategoryID
    LEFT JOIN Product
        ON ProductSubcategory.ProductSubcategoryId = Product.ProductSubcategoryId
    LEFT JOIN OrderDetails
        ON OrderDetails.ProductId = Product.ProductId
    LEFT JOIN Orders
        ON Orders.POS_OrderKey = OrderDetails.POS_OrderKey
    LEFT JOIN Customer
        ON Customer.CustomerId = Orders.CustomerId
    LEFT JOIN CustomerSegment
        ON CustomerSegment.CustomerSegmentId = Customer.CustomerSegmentId
    GROUP BY 1,2 ;
END$$
DELIMITER ; 

