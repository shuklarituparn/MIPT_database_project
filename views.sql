-- HERE I AM COLLECTING THE VIEWS ON MY TABLE

-- VIEWS ARE STORED QUERIES THAT WE CAN RUN INSTEAD OF TYPING ALL QUERIES AT ONCE


--View to show the 5 most booked amenities
CREATE OR REPLACE VIEW popular_amenities AS
SELECT a.AmenityName, COUNT(*) AS NumBookings
FROM airbnbdb.Amenity a
INNER JOIN airbnbdb.PropertyListing pl ON a.PID = pl.PID
INNER JOIN airbnbdb.Booking b ON pl.PID = b.PID
GROUP BY a.AmenityName
ORDER BY NumBookings DESC
LIMIT 5;

SELECT * FROM popular_amenities;

--View to show the property with the number of booking and amount paid
CREATE OR REPLACE VIEW total_amount_paid AS
SELECT pl.PID, pl.PropertyName, COUNT(b.BID) AS NumBookings, SUM(b.AmountPaid) AS TotalAmountPaid
FROM airbnbdb.PropertyListing pl
LEFT JOIN airbnbdb.Booking b ON pl.PID = b.PID
GROUP BY pl.PID, pl.PropertyName;

SELECT * FROM total_amount_paid;


-- Creating the view to get the cleanliness reading for all properties
CREATE OR REPLACE VIEW cleanliness_ratiing AS
SELECT rp.PID, AVG(rp.Cleanliness_Rating) AS AvgCleanlinessRating
FROM airbnbdb.ReviewForProperty rp
GROUP BY rp.PID;

SELECT * FROM cleanliness_ratiing;


