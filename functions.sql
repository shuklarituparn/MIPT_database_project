-- Function to get the average rating of the host with the given ID

CREATE OR REPLACE FUNCTION get_avg_host_rating(uid INT)
    RETURNS DECIMAL(2, 1)
AS
$FUNCTION_BODY$
DECLARE
    total_ratings  DECIMAL(2, 1) := 0;
    number_ratings INT           := 0;
    review         RECORD;
BEGIN
    FOR review IN (SELECT hostrating
                   FROM airbnbdb.reviewforusers
                   WHERE hostuid = uid)
        LOOP
            total_ratings := total_ratings + review.hostrating;
            number_ratings := number_ratings + 1;
        END LOOP;
    IF number_ratings = 0 THEN
        RETURN 0;
    ELSE
        RETURN total_ratings / number_ratings;
    END IF;
END;

$FUNCTION_BODY$ LANGUAGE plpgsql;


-- Average host rating of a given host
SELECT get_avg_host_rating(5);


-- Function to get the minimum bedroom number

CREATE OR REPLACE FUNCTION get_minimum_bedroom_count(bedCount INT)
    RETURNS VOID
AS
$FUNCTION_BODY$
DECLARE
    propID   INT;
    propName VARCHAR(50);
BEGIN
    FOR propID, propName IN
        SELECT PID, PROPERTYNAME
        FROM airbnbdb.propertylisting
        WHERE bedroomcnt >= bedCount
        LOOP
            RAISE NOTICE 'PROPERTY ID: %, PROPERTY NAME: %', propID, propName;   --using notice, so it wont return anything
        END LOOP;
END;
$FUNCTION_BODY$ LANGUAGE plpgsql;


-- Minimum bed count of the property
SELECT get_minimum_bedroom_count(1);



-- Function to get the neighbouring property with a given zipcode

CREATE OR REPLACE FUNCTION get_surrounding_property(PropertyID INT)
    RETURNS VOID
AS
$FUNCTION_BODY$
DECLARE
    zip      INT;
    propID   INT;
    propName VARCHAR(50);
BEGIN
    SELECT Zipcode INTO zip FROM airbnbdb.PropertyListing WHERE PID = PropertyID;

    FOR propID, propName IN
        SELECT PID, PropertyName
        FROM airbnbdb.PropertyListing
        WHERE Zipcode = zip
    LOOP
        RAISE NOTICE 'PROPERTY ID: %, PROPERTY NAME: %', propID, propName;
    END LOOP;
END;
$FUNCTION_BODY$ LANGUAGE plpgsql;


-- Now when we query the property with an ID, we get all surrounding properties
SELECT get_surrounding_property(1);

