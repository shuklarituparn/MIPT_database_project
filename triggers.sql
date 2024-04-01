-- Trigger to mark the isCancelled column to 'Y' if cancel Date is not null
CREATE OR REPLACE FUNCTION set_booking_cancelled_func()
    RETURNS TRIGGER AS
$$
BEGIN
    IF NEW.CancelDate IS NOT NULL THEN
        NEW.IsCancelled := 'Y';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER set_booking_cancelled
    BEFORE UPDATE
    ON airbnbdb.Booking
    FOR EACH ROW
    EXECUTE FUNCTION set_booking_cancelled_func();



-- Testing the trigger

UPDATE airbnbdb.Booking
SET CancelDate = '2024-04-03'
WHERE BID = 2;


-- Trigger to set the privacy of the wishlist to Private (P) by default
CREATE OR REPLACE FUNCTION set_default_privacy()
RETURNS TRIGGER AS
$FUNCTION_BODY$
BEGIN
    IF NEW.Privacy IS NULL THEN
        NEW.Privacy := 'P';
    END IF;
    RETURN NEW;
END;
$FUNCTION_BODY$ LANGUAGE plpgsql;

CREATE TRIGGER set_default_privacy_trigger
BEFORE INSERT ON airbnbdb.WishList
FOR EACH ROW
EXECUTE FUNCTION set_default_privacy();

--Testing the triggers
INSERT INTO airbnbdb.WishList (AirBnBUID, WishlistName)
VALUES (1, 'My Wishlist');

SELECT * FROM airbnbdb.WishList;  --WORKS


-- Trigger to increase the number of rating for a given rating
CREATE OR REPLACE FUNCTION update_num_of_ratings()
RETURNS TRIGGER AS
$FUNCTION_BODY$
BEGIN
    UPDATE airbnbdb.PropertyListing
    SET NumOfRatings = NumOfRatings + 1
    WHERE PID = NEW.PID;

    RETURN NEW;
END;
$FUNCTION_BODY$ LANGUAGE plpgsql;

CREATE TRIGGER update_num_of_ratings_trigger
AFTER INSERT ON airbnbdb.ReviewForProperty
FOR EACH ROW
EXECUTE FUNCTION update_num_of_ratings();


--Testing the trigger after verification
INSERT INTO airbnbdb.ReviewForProperty (GuestID, PID, Created_Time, Modified_Time, CommentInReview, Cleanliness_Rating, Communication_Rating, CheckIn_Rating, Accuracy_Rating, Location_Rating, Value_Rating, Overall_Rating)
VALUES (12, 1, CURRENT_DATE, CURRENT_DATE, 'Great place to stay!', 4.5, 4.8, 4.7, 4.9, 4.6, 4.8, 4.7);

SELECT NumOfRatings FROM airbnbdb.PropertyListing WHERE PID = 1;
