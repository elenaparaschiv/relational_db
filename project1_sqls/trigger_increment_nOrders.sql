-- 15.Create a trigger to increment the value of the customer’s table column “nOrders” 
-- so each time an order created for this customer in the orders table the value  incremented by 1.


CREATE TRIGGER customer_update_nOrders
BEFORE INSERT On Orders
FOR EACH ROW
UPDATE Customers
	SET nOrders = Customers.nOrders + 1
WHERE NEW.CustomerId = Customers.CustomerId


-- tested by adding : 

INSERT INTO Orders(POS_OrderKey,CustomerId,OrderDate,ShipDate,ShipmentModeId)
VALUES("CA_2015-12",8,"2015-01-04","2015-01-05",2)
