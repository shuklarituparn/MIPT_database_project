CREATE SCHEMA IF NOT EXISTS airbnbdb;

DROP TABLE IF EXISTS airbnbdb.reviewforproperty;
CREATE TABLE airbnbdb.ReviewForProperty(
GuestID INT,
PID INT ,
Created_Time Date NOT NULL,
Modified_Time Date,
CommentInReview VARCHAR(1000) ,
Cleanliness_Rating DECIMAL(2,1),
Communication_Rating DECIMAL(2,1),
CheckIn_Rating DECIMAL(2,1),
Accuracy_Rating DECIMAL(2,1),
Location_Rating DECIMAL(2,1),
Value_Rating DECIMAL(2,1),
Overall_Rating DECIMAL(2,1),
PRIMARY KEY(GuestID,PID));

DROP TABLE IF EXISTS airbnbdb.PhotoForPropertyReview;
CREATE TABLE airbnbdb.PhotoForPropertyReview(
GuestID INT ,
PID INT ,
PhotoName VARCHAR(50) ,
PRIMARY KEY(GuestID,PID,PhotoName));

DROP TABLE IF EXISTS airbnbdb.PropertyIncludedInWishlist;
CREATE TABLE airbnbdb.PropertyIncludedInWishlist(
PID INT ,
AirBnBUID INT ,
WishlistName VARCHAR(50) ,
CheckInDate DATE,
CheckOutDate DATE,
PRIMARY KEY(PID,AirBnBUID,WishlistName));

DROP TABLE IF EXISTS  airbnbdb.WishList;
CREATE TABLE airbnbdb.WishList(
AirBnBUID INT ,
WishlistName VARCHAR(50) NOT NULL UNIQUE,
Privacy CHAR(1),
PRIMARY KEY(AirBnBUID,WishlistName));

DROP TABLE IF EXISTS airbnbdb.ReviewForUsers;
CREATE TABLE airbnbdb.ReviewForUsers(
HostUID INT ,
GuestUID INT ,
GuestRating DECIMAL(2,1),HostRating DECIMAL(2,1),
CommentForHost VARCHAR(1000),
CommentForGuest VARCHAR(1000),
PRIMARY KEY(HostUID,GuestUID));

DROP TABLE IF EXISTS airbnbdb.Message;
CREATE TABLE airbnbdb.Message(
HostUID INT ,
GuestID INT ,
Created DATE NOT NULL,
Message_To INT NOT NULL,
Message_From INT NOT NULL,
Body VARCHAR(1000),
PRIMARY KEY(HostUID,GuestID));

DROP TABLE IF EXISTS airbnbdb.Guest CASCADE ;
CREATE TABLE airbnbdb.Guest(
AirBnBUID INT ,
AvgRating DECIMAL(2,1) ,
NumOfRatings INT DEFAULT 0,
PRIMARY KEY(AirBnBUID));

DROP TABLE IF EXISTS airbnbdb.Host CASCADE ;
CREATE TABLE airbnbdb.Host(
AirBnBUID INT ,
IsSuperHost CHAR(1) ,
AvgRating DECIMAL(2,1),
NumOfRatings INT,
PRIMARY KEY(AirBnBUID));

DROP TABLE IF EXISTS airbnbdb.AirBnBUser;
CREATE TABLE airbnbdb.AirBnBUser(
AirBnBUID INT,
DOB DATE,
Email VARCHAR(20) NOT NULL,
UserPassword VARCHAR(20) NOT NULL,
Gender CHAR(1),
About VARCHAR(100),
Phone VARCHAR(15) NOT NULL,
ProfilePhotoName VARCHAR(20),
Address VARCHAR(100),
Fname VARCHAR(20) NOT NULL,
LName VARCHAR(20),
PRIMARY KEY(AirBnBUID));

DROP TABLE IF EXISTS airbnbdb.Amenity;
CREATE TABLE airbnbdb.Amenity(
PID INT ,
AmenityName VARCHAR(20),
PRIMARY KEY(PID,AmenityName));



DROP TABLE IF EXISTS airbnbdb.HouseRule;
CREATE TABLE airbnbdb.HouseRule(
PID INT ,
RuleName VARCHAR(100),
PRIMARY KEY(PID,RuleName));

DROP TABLE IF EXISTS airbnbdb.AvailableBookingSlot;
CREATE TABLE airbnbdb.AvailableBookingSlot(
PID INT ,
StartDate DATE,
EndDate DATE,
PRIMARY KEY(PID,StartDate,EndDate));

DROP TABLE IF EXISTS airbnbdb.Bedroom;
CREATE TABLE airbnbdb.Bedroom(
PropertyID INT ,
BedroomNumber VARCHAR(5),
BedType VARCHAR(10),
BedCnt INT,
PRIMARY KEY(PropertyID,BedroomNumber,BedType,BedCnt));

DROP TABLE IF EXISTS airbnbdb.Category;
CREATE TABLE airbnbdb.Category(
PID INT ,
categoryName VARCHAR(20),
PRIMARY KEY(PID,categoryName));

DROP TABLE IF EXISTS airbnbdb.PropertyListing CASCADE ;
CREATE TABLE airbnbdb.PropertyListing
(
    PID           INT,
    PropertyName  VARCHAR(50),
    Zipcode       INT NOT NULL,
    BathroomCnt   INT,
    BedroomCnt    INT           DEFAULT 0,
    GuestNum      INT,
    PricePerNight DECIMAL(6, 2),
    CheckInTime   TIMESTAMP(0),
    CheckOutTime  TIMESTAMP(0),
    NumOfRatings  INT           DEFAULT 0,
    AvgRatings    DECIMAL(2, 1) DEFAULT 0,
    HID           INT,
    Street        VARCHAR(20),
    City          VARCHAR(20),
    Country       VARCHAR(20),
    PRIMARY KEY (PID)
);


DROP TABLE IF EXISTS airbnbdb.Booking;
CREATE TABLE airbnbdb.Booking(
BID INT,
CheckInDate DATE NOT NULL,
CheckOutDate DATE NOT NULL,
AmountPaid DECIMAL(6,2),
BookingDate DATE NOT NULL,
AdultGuestNum INT DEFAULT 0,
IsCancelled CHAR(1),
CancelDate DATE,
GuestUID INT,
PID INT,
TotalPrice DECIMAL(6,2),
TotalPriceWTax DECIMAL(6,2),
AmountDue DECIMAL(4,2),
PRIMARY KEY(BID));

ALTER TABLE airbnbdb.Guest ADD CONSTRAINT GuestFK_1 FOREIGN KEY(AirBnBUID) REFERENCES
airbnbdb.AirBnBUser(AirBnBUID) ON DELETE CASCADE;

ALTER TABLE airbnbdb.Host ADD CONSTRAINT HostFK_1 FOREIGN KEY(AirBnBUID) REFERENCES
airbnbdb.AirBnBUser(AirBnBUID) ON DELETE CASCADE ;

ALTER TABLE airbnbdb.ReviewForProperty ADD CONSTRAINT ReviewForPropertyFK_1 FOREIGN
KEY(GuestID) REFERENCES airbnbdb.Guest(AirBnBUID) ON DELETE CASCADE ;

ALTER TABLE airbnbdb.ReviewForProperty ADD CONSTRAINT ReviewForPropertyFK_2 FOREIGN
KEY(PID) REFERENCES airbnbdb.PropertyListing(PID) ON DELETE CASCADE ;

ALTER TABLE airbnbdb.PhotoForPropertyReview ADD CONSTRAINT PhotoForPropertyReviewFK_1
FOREIGN KEY(GuestID) REFERENCES airbnbdb.Guest(AirBnBUID) ON DELETE CASCADE ;

ALTER TABLE airbnbdb.PhotoForPropertyReview ADD CONSTRAINT PhotoForPropertyReviewFK_2
FOREIGN KEY(PID) REFERENCES airbnbdb.PropertyListing(PID) ON DELETE CASCADE ;

ALTER TABLE airbnbdb.PropertyIncludedInWishlist ADD CONSTRAINT
PropertyIncludedInWishlistFK_1 FOREIGN KEY(AirBnBUID) REFERENCES
airbnbdb.Guest(AirBnBUID) ON DELETE CASCADE ;

ALTER TABLE airbnbdb.PropertyIncludedInWishlist ADD CONSTRAINT
PropertyIncludedInWishlistFK_2 FOREIGN KEY(PID) REFERENCES
airbnbdb.PropertyListing(PID) ON DELETE CASCADE ;

ALTER TABLE airbnbdb.PropertyIncludedInWishlist ADD CONSTRAINT
PropertyIncludedInWishlistFK_3 FOREIGN KEY(WishlistName) REFERENCES
airbnbdb.WishList(WishlistName) ON DELETE CASCADE;

ALTER TABLE airbnbdb.WishList ADD CONSTRAINT WishListFK_1 FOREIGN KEY(AirBnBUID)
REFERENCES airbnbdb.Guest(AirBnBUID) ON DELETE CASCADE;

ALTER TABLE airbnbdb.ReviewForUsers ADD CONSTRAINT ReviewForUsersFK_1 FOREIGN
KEY(HostUID) REFERENCES airbnbdb.Host(AirBnBUID) ON DELETE CASCADE ;

ALTER TABLE airbnbdb.ReviewForUsers ADD CONSTRAINT ReviewForUsersFK_2 FOREIGN
KEY(GuestUID) REFERENCES airbnbdb.Guest(AirBnBUID) ON DELETE CASCADE ;

ALTER TABLE airbnbdb.Message ADD CONSTRAINT MessageFK_1 FOREIGN KEY(HostUID)
REFERENCES airbnbdb.Host(AirBnBUID) ON DELETE CASCADE ;

ALTER TABLE airbnbdb.Message ADD CONSTRAINT MessageFK_2 FOREIGN KEY(GuestID)
REFERENCES airbnbdb.Guest(AirBnBUID) ON DELETE CASCADE ;

ALTER TABLE airbnbdb.Amenity ADD CONSTRAINT AmenityFK_1 FOREIGN KEY(PID) REFERENCES
airbnbdb.PropertyListing(PID) ON DELETE CASCADE ;

ALTER TABLE airbnbdb.HouseRule ADD CONSTRAINT HouseRuleFK_1 FOREIGN KEY(PID)
REFERENCES airbnbdb.PropertyListing(PID) ON DELETE CASCADE ;

ALTER TABLE airbnbdb.AvailableBookingSlot ADD CONSTRAINT AvailableBookingSlotFK_1
FOREIGN KEY(PID) REFERENCES airbnbdb.PropertyListing(PID) ON DELETE CASCADE ;

ALTER TABLE airbnbdb.Bedroom ADD CONSTRAINT BedroomFK_1 FOREIGN KEY(PropertyID)
REFERENCES airbnbdb.PropertyListing(PID) ON DELETE CASCADE ;

ALTER TABLE airbnbdb.Category ADD CONSTRAINT CategoryFK_1 FOREIGN KEY(PID) REFERENCES
airbnbdb.PropertyListing(PID) ON DELETE CASCADE ;

ALTER TABLE airbnbdb.PROPERTYLISTING ADD CONSTRAINT propertyFK_1 FOREIGN KEY(HID)
REFERENCES airbnbdb.Host(AIRBNBUID) ON DELETE CASCADE ;

ALTER TABLE airbnbdb.Booking ADD CONSTRAINT BookingFK_1 FOREIGN KEY(GuestUID)
REFERENCES airbnbdb.Guest(AirBnBUID) ON DELETE CASCADE ;

ALTER TABLE airbnbdb.Booking ADD CONSTRAINT BookingFK_2 FOREIGN KEY(PID) REFERENCES
airbnbdb.PropertyListing(PID) ON DELETE CASCADE ;
