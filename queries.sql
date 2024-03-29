-- List all properties with average rating and number of rating

SELECT airbnb.propertylisting.pid,airbnb.propertylisting.propertyname, airbnb.propertylisting.avgratings, airbnb.propertylisting.numofratings
       FROM  airbnb.propertylisting WHERE airbnb.propertylisting.numofratings>10 ;


-- Properties with their average ratings and host information:
SELECT PL.PropertyName, PL.AvgRatings, H.IsSuperHost, H.AvgRating
FROM PropertyListing PL
JOIN Host H ON PL.HID = H.AirBnBUID;


-- Properties in a certain city with their respective categories:
SELECT PL.PropertyName, C.categoryName
FROM PropertyListing PL
JOIN Category C ON PL.PID = C.PID
WHERE PL.City = 'Smalltown';

-- Amenities available for a specific property:
SELECT A.AmenityName
FROM Amenity A
JOIN PropertyListing PL ON A.PID = PL.PID
WHERE PL.PropertyName = 'Cozy Cottage';


-- All messages sent between a host and a guest:
SELECT M.*
FROM Message M
WHERE M.HostUID = 2 AND M.GuestID = 3;



-- All properties with their available booking slots:
SELECT PL.PropertyName, ABS.StartDate, ABS.EndDate
FROM PropertyListing PL
JOIN AvailableBookingSlot ABS ON PL.PID = ABS.PID;


-- All house rules associated with each property
SELECT hr.*, pl.PropertyName
FROM HouseRule hr
INNER JOIN PropertyListing pl ON hr.PID = pl.PID;


-- All properties with the number of booking and the amount paid
SELECT pl.PID, pl.PropertyName, COUNT(b.BID) AS NumBookings, SUM(b.AmountPaid) AS TotalAmountPaid
FROM PropertyListing pl
LEFT JOIN Booking b ON pl.PID = b.PID
GROUP BY pl.PID, pl.PropertyName;


-- Getting the cleanliness reading for all properties
SELECT rp.PID, AVG(rp.Cleanliness_Rating) AS AvgCleanlinessRating
FROM ReviewForProperty rp
GROUP BY rp.PID;


-- Getting the hosts, the number of property they hosted and their average rating
SELECT h.AirBnBUID, COUNT(pl.PID) AS NumPropertiesHosted, AVG(h.AvgRating) AS AvgHostRating
FROM Host h
LEFT JOIN PropertyListing pl ON h.AirBnBUID = pl.HID
GROUP BY h.AirBnBUID;


-- Getting the 5 most booked amenities along all the bookings
SELECT a.AmenityName, COUNT(*) AS NumBookings
FROM Amenity a
INNER JOIN PropertyListing pl ON a.PID = pl.PID
INNER JOIN Booking b ON pl.PID = b.PID
GROUP BY a.AmenityName
ORDER BY NumBookings DESC
LIMIT 5;




