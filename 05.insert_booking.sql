INSERT INTO airbnbdb.Booking (BID, CheckInDate, CheckOutDate, AmountPaid, BookingDate, AdultGuestNum, IsCancelled,
                              CancelDate, GuestUID, PID, TotalPrice, TotalPriceWTax, AmountDue)
VALUES (1, '2024-04-01', '2024-04-05', 50.00, '2024-03-25', 2, 'N', NULL, 1, 1, 50.00, 52.50, 52.50),
       (2, '2024-04-10', '2024-04-15', 80.00, '2024-03-28', 3, 'N', NULL, 2, 3, 80.00, 84.00, 84.00),
       (3, '2024-04-05', '2024-04-10', 60.00, '2024-03-30', 1, 'N', NULL, 5, 5, 60.00, 63.00, 63.00),
       (4, '2024-04-15', '2024-04-20', 75.00, '2024-04-01', 6, 'N', NULL, 3, 2, 75.00, 78.75, 78.70),
       (5, '2024-04-20', '2024-04-25', 90.00, '2024-04-03', 2, 'N', NULL, 7, 7, 90.00, 94.50, 94.50),
       (6, '2024-04-25', '2024-04-30', 70.00, '2024-04-05', 2, 'N', NULL, 8, 9, 70.00, 73.50, 73.50),
       (7, '2024-05-01', '2024-05-05', 60.00, '2024-04-10', 3, 'N', NULL, 9, 10, 60.00, 63.00, 63.00),
       (8, '2024-05-06', '2024-05-10', 85.00, '2024-04-15', 1, 'N', NULL, 10, 12, 85.00, 89.25, 89.20),
       (9, '2024-05-11', '2024-05-15', 70.00, '2024-04-20', 1, 'N', NULL, 11, 14, 70.00, 73.50, 73.50),
       (10, '2024-05-16', '2024-05-20', 95.00, '2024-04-25', 3, 'N', NULL, 12, 15, 95.00, 99.75, 99.70),
       (11, '2024-05-21', '2024-05-25', 80.00, '2024-05-01', 2, 'N', NULL, 6, 12, 80.00, 84.00, 84.00),
       (12, '2024-05-26', '2024-05-30', 70.00, '2024-05-05', 7, 'N', NULL, 4, 10, 70.00, 73.50, 73.50),
       (13, '2024-06-01', '2024-06-05', 60.00, '2024-05-10', 1, 'N', NULL, 13, 8, 60.00, 63.00, 63.00),
       (14, '2024-06-06', '2024-06-10', 85.00, '2024-05-15', 1, 'N', NULL, 15, 9, 85.00, 89.25, 89.20),
       (15, '2024-06-11', '2024-06-15', 70.00, '2024-05-20', 2, 'N', NULL, 14, 14, 70.00, 73.50, 73.50);