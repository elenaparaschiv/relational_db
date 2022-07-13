-- 14.Create a view to show(Year, Month, Product Category, Segment, nOrders, Sales, Revenue).

CREATE VIEW sales_yearMonth_categ_segnent AS

    SELECT
        DISTINCT
        YEAR(Orders.OrderDate) AS yearo,
        MONTH(Orders.OrderDate) AS montho,
        ProductCategory.ProductCategoryName,
        CustomerSegment.CustomerSegmentName,
        SUM(Customers.nOrders) as total_nOrders,
        SUM(OrderDetails.Sale) as sum_sale
    FROM ProductCategory
    LEFT JOIN ProductSubcategory
        ON ProductCategory.ProductCategoryID = ProductSubcategory.ProductCategoryID
    LEFT JOIN Product
        ON Product.ProductSubcategoryId = ProductSubcategory.ProductSubcategoryId
    LEFT JOIN OrderDetails
        ON OrderDetails.ProductId = Product.ProductId
    LEFT JOIN Orders
        ON Orders.POS_OrderKey = OrderDetails.POS_OrderKey
    LEFT JOIN Customers
        ON Customers.CustomerId = Orders.CustomerId
    LEFT JOIN CustomerSegment
        ON CustomerSegment.CustomerSegmentId = Customers.CustomerSegmentId
    GROUP BY  1,2,3,4
