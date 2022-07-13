-- 10. Create a stored procedure  that returns all the details 
-- of the transactions with a Profit Ratio < 0%

DELIMITER $$     
CREATE PROCEDURE profitRatio_belowZero ()
BEGIN
    SELECT 
        *,
         IFNULL(FORMAT((Profit / Sale), 2),0) as ProfitRatio -- calculates the P.R. < 0
    FROM `OrderDetails`
    WHERE  IFNULL(FORMAT((Profit / Sale), 2),0) < 0; -- filter the P.R. < 0
END $$
DELIMITER ;
