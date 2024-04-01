import pytest
import psycopg2
import os
from dotenv import load_dotenv

load_dotenv()

db_name = os.environ.get("DB_NAME")
db_user = os.environ.get("DB_USER")
db_password = os.environ.get("DB_PASSWORD")
db_host = os.environ.get("DB_HOST")
db_port = os.environ.get("DB_PORT")

# Function to establish a connection to the PostgreSQL database
def connect_to_db():
    conn = psycopg2.connect(
        dbname=db_name,
        user=db_user,
        password=db_password,
        host=db_host,
        port=db_port
    )
    return conn


# Define test functions
def test_get_elements_in_column():
    conn = connect_to_db()  # Connecting to the database
    cur = conn.cursor()  # using
    cur.execute("SELECT PropertyName FROM airbnbdb.PropertyListing")
    elements = cur.fetchall()
    cur.close()
    conn.close()
    assert elements, "No elements found in the column"
    print("Elements in the column:")
    for element in elements:
        print(element[0])


def test_list_properties_with_avg_rating_and_num_of_ratings():
    conn = connect_to_db()
    cur = conn.cursor()
    cur.execute("""
        SELECT pid, propertyname, avgratings, numofratings
        FROM airbnbdb.propertylisting
        WHERE numofratings > 10
    """)
    rows = cur.fetchall()
    cur.close()
    conn.close()
    assert len(rows) > 0, "No properties with more than 10 ratings found"


def test_properties_with_avg_ratings_and_host_info():
    conn = connect_to_db()
    cur = conn.cursor()
    cur.execute("""
        SELECT PL.PropertyName, PL.AvgRatings, H.IsSuperHost, H.AvgRating
        FROM airbnbdb.PropertyListing PL
        JOIN airbnbdb.Host H ON PL.HID = H.AirBnBUID
    """)
    rows = cur.fetchall()
    cur.close()
    conn.close()
    assert len(rows) > 0, "No properties with average ratings and host information found"


def test_properties_in_city_with_categories():
    conn = connect_to_db()
    cur = conn.cursor()
    cur.execute("""
        SELECT PL.PropertyName, C.categoryName
        FROM airbnbdb.PropertyListing PL
        JOIN airbnbdb.Category C ON PL.PID = C.PID
        WHERE PL.City = 'Smalltown'
    """)
    rows = cur.fetchall()
    cur.close()
    conn.close()
    assert len(rows) > 0, "No properties with categories found in the specified city"


def test_amenities_for_specific_property():
    conn = connect_to_db()
    cur = conn.cursor()
    property_name = 'Cozy Cottage'
    cur.execute("""
        SELECT A.AmenityName
        FROM airbnbdb.Amenity A
        JOIN airbnbdb.PropertyListing PL ON A.PID = PL.PID
        WHERE PL.PropertyName = %s
    """, (property_name,))
    rows = cur.fetchall()
    cur.close()
    conn.close()
    assert len(rows) > 0, f"No amenities found for the property '{property_name}'"


def test_messages_between_host_and_guest():
    conn = connect_to_db()
    cur = conn.cursor()
    host_id = 2
    guest_id = 3
    cur.execute("""
        SELECT M.*
        FROM airbnbdb.Message M
        WHERE M.HostUID = %s AND M.GuestID = %s
    """, (host_id, guest_id))
    rows = cur.fetchall()
    cur.close()
    conn.close()
    assert len(rows) > 0, f"No messages found between HostID={host_id} and GuestID={guest_id}"


def test_properties_with_available_booking_slots():
    conn = connect_to_db()
    cur = conn.cursor()
    cur.execute("""
        SELECT PL.PropertyName, ABS.StartDate, ABS.EndDate
        FROM airbnbdb.PropertyListing PL
        JOIN airbnbdb.AvailableBookingSlot ABS ON PL.PID = ABS.PID
    """)
    rows = cur.fetchall()
    cur.close()
    conn.close()
    assert len(rows) > 0, "No properties found with available booking slots"


def test_house_rules_associated_with_properties():
    conn = connect_to_db()
    cur = conn.cursor()
    cur.execute("""
        SELECT hr.*, pl.PropertyName
        FROM airbnbdb.HouseRule hr
        INNER JOIN airbnbdb.PropertyListing pl ON hr.PID = pl.PID
    """)
    rows = cur.fetchall()
    cur.close()
    conn.close()
    assert len(rows) > 0, "No house rules found associated with properties"


def test_properties_with_booking_info():
    conn = connect_to_db()
    cur = conn.cursor()
    cur.execute("""
        SELECT pl.PID, pl.PropertyName, COUNT(b.BID) AS NumBookings, SUM(b.AmountPaid) AS TotalAmountPaid
        FROM airbnbdb.PropertyListing pl
        LEFT JOIN airbnbdb.Booking b ON pl.PID = b.PID
        GROUP BY pl.PID, pl.PropertyName
    """)
    rows = cur.fetchall()
    cur.close()
    conn.close()
    assert len(rows) > 0, "No properties found with booking information"


def test_cleanliness_ratings_for_properties():
    conn = connect_to_db()
    cur = conn.cursor()
    cur.execute("""
        SELECT rp.PID, AVG(rp.Cleanliness_Rating) AS AvgCleanlinessRating
        FROM airbnbdb.ReviewForProperty rp
        GROUP BY rp.PID
    """)
    rows = cur.fetchall()
    cur.close()
    conn.close()
    assert len(rows) > 0, "No cleanliness ratings found for properties"


def test_host_properties_and_ratings():
    conn = connect_to_db()
    cur = conn.cursor()
    cur.execute("""
        SELECT h.AirBnBUID, COUNT(pl.PID) AS NumPropertiesHosted, AVG(h.AvgRating) AS AvgHostRating
        FROM airbnbdb.Host h
        LEFT JOIN airbnbdb.PropertyListing pl ON h.AirBnBUID = pl.HID
        GROUP BY h.AirBnBUID;
    """)
    rows = cur.fetchall()
    cur.close()
    conn.close()
    assert len(rows) > 0, "No hosts found"
    for row in rows:
        assert row[1] > 0, f"Host {row[0]} has not hosted any properties"


def test_top_5_booked_amenities():
    conn = connect_to_db()
    cur = conn.cursor()
    cur.execute("""
        SELECT a.AmenityName, COUNT(*) AS NumBookings
        FROM airbnbdb.Amenity a
        INNER JOIN airbnbdb.PropertyListing pl ON a.PID = pl.PID
        INNER JOIN airbnbdb.Booking b ON pl.PID = b.PID
        GROUP BY a.AmenityName
        ORDER BY NumBookings DESC
        LIMIT 5;
    """)
    rows = cur.fetchall()
    cur.close()
    conn.close()
    assert len(rows) > 0, "No amenities found"
    assert len(rows) == 5, "Expected 5 amenities, but got a different number"
    for row in rows:
        assert row[1] > 0, f"Amenity {row[0]} has 0 bookings"

if __name__ == "__main__":
    pytest.main()
