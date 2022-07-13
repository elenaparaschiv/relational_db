
-- We want to see the most popular product in each category for that year

-- 8. Create a function that takes a category and year and 
-- returns what is the most popular product (Qty) in that category in a specific year (window fn)

-- TODO: Transform it in a function just like 6.

SELECT 
    ProductName,
    most_popular
FROM
(
SELECT 
     Product.ProductName,
     SUM(OrderDetails.Qty) OVER (PARTITION BY Product.ProductName ORDER BY Product.ProductName) as most_popular
    FROM 
    ProductCategory
    LEFT JOIN ProductSubcategory
        ON ProductCategory.ProductCategoryID = ProductSubcategory.ProductCategoryID
    LEFT JOIN Product
        ON Product.ProductSubcategoryId = ProductSubcategory.ProductSubcategoryId
    LEFT JOIN OrderDetails
        ON OrderDetails.ProductId = Product.ProductId
    LEFT JOIN Orders
        ON Orders.POS_OrderKey = OrderDetails.POS_OrderKey
    WHERE  ProductCategory.ProductCategoryName = "Technology" -- the category you selected
    AND Year(Orders.ShipDate) = 2016 -- the year param
)as subq
GROUP BY most_popular desc
LIMIT 1 -- the first most sold