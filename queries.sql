-- List all properties with average rating and number of rating
SELECT airbnbdb.propertylisting.pid,airbnbdb.propertylisting.propertyname, airbnbdb.propertylisting.avgratings, airbnbdb.propertylisting.numofratings
       FROM  airbnbdb.propertylisting WHERE airbnbdb.propertylisting.numofratings>10 ;


-- Properties with their average ratings and host information:
SELECT PL.PropertyName, PL.AvgRatings, H.IsSuperHost, H.AvgRating
FROM airbnbdb.PropertyListing PL
JOIN airbnbdb.Host H ON PL.HID = H.AirBnBUID;


-- Properties in a certain city with their respective categories:
SELECT PL.PropertyName, C.categoryName
FROM airbnbdb.PropertyListing PL
JOIN airbnbdb.Category C ON PL.PID = C.PID
WHERE PL.City = 'Smalltown';

-- Amenities available for a specific property:
SELECT A.AmenityName
FROM airbnbdb.Amenity A
JOIN airbnbdb.PropertyListing PL ON A.PID = PL.PID
WHERE PL.PropertyName = 'Cozy Cottage';


-- All messages sent between a host and a guest:
SELECT M.*
FROM airbnbdb.Message M
WHERE M.HostUID = 2 AND M.GuestID = 3;



-- All properties with their available booking slots:
SELECT PL.PropertyName, ABS.StartDate, ABS.EndDate
FROM airbnbdb.PropertyListing PL
JOIN airbnbdb.AvailableBookingSlot ABS ON PL.PID = ABS.PID;


-- All house rules associated with each property
SELECT hr.*, pl.PropertyName
FROM airbnbdb.HouseRule hr
INNER JOIN airbnbdb.PropertyListing pl ON hr.PID = pl.PID;


-- All properties with the number of booking and the amount paid
SELECT pl.PID, pl.PropertyName, COUNT(b.BID) AS NumBookings, SUM(b.AmountPaid) AS TotalAmountPaid
FROM airbnbdb.PropertyListing pl
LEFT JOIN airbnbdb.Booking b ON pl.PID = b.PID
GROUP BY pl.PID, pl.PropertyName;


-- Getting the cleanliness reading for all properties
SELECT rp.PID, AVG(rp.Cleanliness_Rating) AS AvgCleanlinessRating
FROM airbnbdb.ReviewForProperty rp
GROUP BY rp.PID;


-- Getting the hosts, the number of property they hosted and their average rating
SELECT h.AirBnBUID, COUNT(pl.PID) AS NumPropertiesHosted, AVG(h.AvgRating) AS AvgHostRating
FROM airbnbdb.Host h
LEFT JOIN airbnbdb.PropertyListing pl ON h.AirBnBUID = pl.HID
GROUP BY h.AirBnBUID;


-- Getting the 5 most booked amenities along all the bookings
SELECT a.AmenityName, COUNT(*) AS NumBookings
FROM airbnbdb.Amenity a
INNER JOIN airbnbdb.PropertyListing pl ON a.PID = pl.PID
INNER JOIN airbnbdb.Booking b ON pl.PID = b.PID
GROUP BY a.AmenityName
ORDER BY NumBookings DESC
LIMIT 5;




