-- Indexes on the database

-- Index on the property id

CREATE INDEX CheckInDate_idx ON airbnbdb.booking(checkindate);
CREATE INDEX CheckOutDate_idx ON airbnbdb.booking(checkoutdate);


-- Using the index to query the database now

SELECT * FROM airbnbdb.booking WHERE checkindate='2024-04-01';



-- Now creating index on the property listing

CREATE INDEX PropertyID_idx ON airbnbdb.propertylisting(pid);

-- Now the query with number of bookings and the amount paid
SELECT pl.PID, pl.PropertyName, COUNT(b.BID) AS NumBookings, SUM(b.AmountPaid) AS TotalAmountPaid
FROM airbnbdb.PropertyListing pl
LEFT JOIN airbnbdb.Booking b ON pl.PID = b.PID
GROUP BY pl.PID, pl.PropertyName;




