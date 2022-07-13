
-- We want to see the most profitable city in a State at a year we specify and the profit it had.

-- 6.Create a function that takes a state and year as parameters and 
-- return the most profitable City in this State this year and the annual profit for that city

DELIMITER $$
CREATE FUNCTION mostProfitableCity_byState_byYear(
   _state VARCHAR(200),
   _year INT
)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE 
    	cityProfit VARCHAR(100);
	SET 
    cityProfit = (
        SELECT CONCAT(CityName, ': ', _profit)
        FROM 
        (
            SELECT
                CityName,
                yearo,
                SUM(total_profit) as _profit
            FROM
            (
                SELECT
                City.CityName,
                YEAR(Orders.ShipDate) as yearo,
                OrderDetails.Profit as total_profit
                FROM 
                State
                LEFT JOIN City on State.StateId = City.StateId
                LEFT JOIN Customer ON City.CityId = Customer.CityId
                LEFT JOIN Orders ON Customer.CustomerId = Orders.CustomerId
                LEFT JOIN OrderDetails ON Orders.POS_OrderKey = OrderDetails.POS_OrderKey
                WHERE State.StateName = _state -- we filter by state
            ) as subq
            WHERE yearo = _year -- we filter by year
            GROUP BY 1,2
            ORDER BY _profit desc
            LIMIT 1 -- returns the most popular 
        ) as sub2
    );
    RETURN cityProfit;
 
END$$
DELIMITER ;

