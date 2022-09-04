
-- SECTION-ONE

-- Task 1 
/* Insert your codes in the correct order of execution. If Table A needs to be created before Table B, add codes in cthe orrect order */

-- Table creation

CREATE TABLE VillaType (
    VillaTypeID varchar(5),
    VillaTypeName varchar(255),
    PRIMARY KEY (VillaTypeID)
);

CREATE TABLE Villa (
    VillaID varchar(5),
    VillaName varchar(255),
    VillaCostPerDay decimal(5,2),
    VillaTypeID varchar(5),
    PRIMARY KEY (VillaID),
    FOREIGN KEY (VillaTypeID) REFERENCES VillaType(VillaTypeID)
);

CREATE TABLE Customer (
    CustomerID varchar(5),
    CustomerName varchar(255),
    CustomerPhNum varchar(10),
    PRIMARY KEY (CustomerID)
);


CREATE TABLE Reservation (
    ReservationID varchar(5),
    ReservationDate date,
    CustomerID varchar(5),
    PRIMARY KEY (ReservationID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);
CREATE TABLE VillaReservation (
    ReservationID varchar(5),
    VillaID varchar(5),
    DateFrom date,
    DateTo date,
    CONSTRAINT villa_reserve_pk PRIMARY KEY (ReservationID, VillaID),
    FOREIGN KEY (ReservationID) REFERENCES Reservation(ReservationID),
    FOREIGN KEY (VillaID) REFERENCES Villa(VillaID)
);

CREATE TABLE Payment (
    PaymentID varchar(5),
    ReservationID varchar(5),
    PaymentDate date,
    PaymentAmount decimal(6,2),
    PRIMARY KEY (PaymentID),
    FOREIGN KEY (ReservationID) REFERENCES Reservation(ReservationID)
);


-- Data Insertion


INSERT INTO VillaType (VillaTypeID, VillaTypeName)
VALUES ('T1', 'One-bedroom Villa without Pool');
INSERT INTO VillaType (VillaTypeID, VillaTypeName)
VALUES ('T2', 'two-bedroom Villa with Pool');
INSERT INTO VillaType (VillaTypeID, VillaTypeName)
VALUES ('T3', 'two-bedroom Villa without Pool');
INSERT INTO VillaType (VillaTypeID, VillaTypeName)
VALUES ('T4', 'One-bedroom Villa with Pool');
INSERT INTO VillaType (VillaTypeID, VillaTypeName)
VALUES ('T5', 'three-bedroom Villa with Pool');


INSERT INTO Villa (VillaID, VillaName, VillaCostPerDay, VillaTypeID)
VALUES ('V14', 'Serene Bliss', 785.95, 'T1');
INSERT INTO Villa (VillaID, VillaName, VillaCostPerDay, VillaTypeID)
VALUES ('V15', 'Ultimate Bliss', 765.45, 'T1');
INSERT INTO Villa (VillaID, VillaName, VillaCostPerDay, VillaTypeID)
VALUES ('V16', 'Perfect Bliss', 965.25, 'T2');
INSERT INTO Villa (VillaID, VillaName, VillaCostPerDay, VillaTypeID)
VALUES ('V17', 'Awesome Villa', 999.99, 'T3');
INSERT INTO Villa (VillaID, VillaName, VillaCostPerDay, VillaTypeID)
VALUES ('V18', 'Nice Villa', 888.25, 'T4');


INSERT INTO Customer (CustomerID, CustomerName, CustomerPhNum)
VALUES ('C345', 'Hugh Jackman', '0415871256');
INSERT INTO Customer (CustomerID, CustomerName, CustomerPhNum)
VALUES ('C346', 'Steve Smith', '0415871942');
INSERT INTO Customer (CustomerID, CustomerName, CustomerPhNum)
VALUES ('C347', 'Ricardo Milos', '0415823442');
INSERT INTO Customer (CustomerID, CustomerName, CustomerPhNum)
VALUES ('C348', 'Ricky Ponting', '0415121942');
INSERT INTO Customer (CustomerID, CustomerName, CustomerPhNum)
VALUES ('C349', 'David Warner', '0415871922');


INSERT INTO Reservation (ReservationID, ReservationDate, CustomerID)
VALUES ('R321', to_date('06-12-2020'), 'C345');
INSERT INTO Reservation (ReservationID, ReservationDate, CustomerID)
VALUES ('R322', to_date('05-10-2020'), 'C346');
INSERT INTO Reservation (ReservationID, ReservationDate, CustomerID)
VALUES ('R323', to_date('02-01-2020'), 'C347');
INSERT INTO Reservation (ReservationID, ReservationDate, CustomerID)
VALUES ('R324', to_date('04-15-2020'), 'C348');
INSERT INTO Reservation (ReservationID, ReservationDate, CustomerID)
VALUES ('R325', to_date('03-11-2020'), 'C349');


INSERT INTO VillaReservation (ReservationID, VillaID, DateFrom, DateTo)
VALUES ('R321', 'V15', to_date('12-04-2020'), to_date('12-10-2020'));
INSERT INTO VillaReservation (ReservationID, VillaID, DateFrom, DateTo)
VALUES ('R321', 'V15', to_date('12-04-2020'), to_date('12-10-2020'));
INSERT INTO VillaReservation (ReservationID, VillaID, DateFrom, DateTo)
VALUES ('R323', 'V16', to_date('02-04-2020'), to_date('02-10-2020'));
INSERT INTO VillaReservation (ReservationID, VillaID, DateFrom, DateTo)
VALUES ('R324', 'V17', to_date('04-18-2020'), to_date('04-20-2020'));
INSERT INTO VillaReservation (ReservationID, VillaID, DateFrom, DateTo)
VALUES ('R325', 'V18', to_date('03-18-2020'), to_date('03-23-2020'));


INSERT INTO Payment (PaymentID, ReservationID, PaymentDate, PaymentAmount)
VALUES ('P300', 'R321', to_date('06-13-2020'), 3000.00);
INSERT INTO Payment (PaymentID, ReservationID, PaymentDate, PaymentAmount)
VALUES ('P301', 'R322', to_date('05-02-2020'), 4000.00);
INSERT INTO Payment (PaymentID, ReservationID, PaymentDate, PaymentAmount)
VALUES ('P302', 'R323', to_date('02-12-2020'), 3500.00);
INSERT INTO Payment (PaymentID, ReservationID, PaymentDate, PaymentAmount)
VALUES ('P303', 'R324', to_date('04-22-2020'), 4500.00);
INSERT INTO Payment (PaymentID, ReservationID, PaymentDate, PaymentAmount)
VALUES ('P304', 'R325', to_date('03-24-2020'), 2500.00);



-- Task 2

SELECT VILLAID,VILLANAME,to_char(VILLACOSTPERDAY, '$999.99'),VILLATYPEID FROM VILLA
ORDER BY VILLACOSTPERDAY DESC;

-- Task 3

SELECT VILLAID, DATEFROM, DATETO, DATETO-DATEFROM AS NUMBER_OF_DAYS
FROM VILLARESERVATION;

-- Task 4

SELECT VILLANAME,VILLACOSTPERDAY FROM VILLA
WHERE VILLATYPEID IN
    ( SELECT VILLATYPEID FROM VILLATYPE
      WHERE VILLATYPE.VILLATYPENAME LIKE '%two-bedroom%'
    );

-- Task 5

SELECT RESERVATIONID FROM RESERVATION
WHERE 5 >=
    ( SELECT PAYMENT.PAYMENTDATE-RESERVATION.RESERVATIONDATE FROM PAYMENT
      WHERE RESERVATION.RESERVATIONID = PAYMENT.RESERVATIONID
    );

-- Task 6

SELECT CUSTOMERNAME,CUSTOMERPHNUM FROM CUSTOMER
WHERE 6 >= 
    ( 
            SELECT MONTHS_BETWEEN(SYSDATE, RESERVATIONDATE)
            FROM RESERVATION
            WHERE CUSTOMER.CUSTOMERID = RESERVATION.CUSTOMERID
    );

-- Task 7

SELECT C.CUSTOMERNAME,C.CUSTOMERPHNUM
FROM CUSTOMER C
JOIN RESERVATION R ON C.CUSTOMERID = R.CUSTOMERID
WHERE MONTHS_BETWEEN(SYSDATE, R.RESERVATIONDATE) <= 6;

-- Task 8

SELECT CUSTOMERNAME
FROM CUSTOMER
WHERE CUSTOMERID = 
    (
        SELECT CUSTOMERID FROM RESERVATION
        WHERE RESERVATION.CUSTOMERID = CUSTOMER.CUSTOMERID
        AND
        RESERVATION.RESERVATIONID = 
            ANY(
                SELECT RESERVATIONID FROM VILLARESERVATION
                WHERE VILLARESERVATION.RESERVATIONID = RESERVATION.RESERVATIONID
                AND
                VILLAID = 
                    (
                        SELECT VILLAID FROM VILLA
                        WHERE VILLARESERVATION.VILLAID = VILLA.VILLAID
                        AND VILLA.VILLACOSTPERDAY < 1000
                    )
            )
    )
;

-- Task 9

SELECT RESERVATIONID,PAYMENTAMOUNT 
FROM PAYMENT
ORDER BY PAYMENTAMOUNT DESC;

-- Task 10

SELECT RESERVATIONID, 
    (
        SELECT RESERVATIONDATE
        FROM RESERVATION
        WHERE VILLARESERVATION.RESERVATIONID = RESERVATION.RESERVATIONID
    ) AS RESERVATIONDATE, COUNT(VILLAID) AS NO_OF_VILLAS
FROM VILLARESERVATION
GROUP BY RESERVATIONID
HAVING COUNT(VILLAID) > 1;

-- Task 11

SELECT *
FROM VILLA
WHERE NOT EXISTS
    (
        SELECT VILLAID
        FROM VILLARESERVATION
        WHERE VILLARESERVATION.VILLAID = VILLA.VILLAID
    );

-- Task 12

SELECT *
FROM PAYMENT
WHERE PAYMENTAMOUNT > 1500
AND TO_CHAR(PAYMENTDATE, 'YYYY') = '2020' 
OR TO_CHAR(PAYMENTDATE, 'YYYY') = '2018'
OR TO_CHAR(PAYMENTDATE, 'MM') = '01'
ORDER BY PAYMENTAMOUNT DESC;

-- Task 13

SELECT * FROM PAYMENT
WHERE RESERVATIONID = 
    (
        SELECT RESERVATIONID
        FROM RESERVATION
        WHERE PAYMENT.RESERVATIONID = RESERVATION.RESERVATIONID
        AND RESERVATION.CUSTOMERID = 
            (
                SELECT CUSTOMERID
                FROM CUSTOMER
                WHERE RESERVATION.CUSTOMERID = CUSTOMER.CUSTOMERID
                AND REGEXP_LIKE(CUSTOMER.CUSTOMERNAME, '(*) J(*)')
            )
        AND RESERVATION.RESERVATIONID = 
        ANY(
                SELECT RESERVATIONID
                FROM VILLARESERVATION
                WHERE VILLARESERVATION.RESERVATIONID = RESERVATION.RESERVATIONID
                AND VILLAID = 
                    (
                        SELECT VILLAID
                        FROM VILLA
                        WHERE VILLARESERVATION.VILLAID = VILLA.VILLAID
                        AND VILLATYPEID = 
                            (
                                SELECT VILLATYPEID
                                FROM VILLATYPE
                                WHERE VILLATYPE.VILLATYPEID = VILLA.VILLATYPEID
                                AND VILLATYPE.VILLATYPENAME LIKE '%One-bedroom%'
                            )
                    )
            )
    );

-- SECTION-TWO

/* Insert table creation and data for populating the tables */

CREATE TABLE Staff (
    StaffID varchar(5),
    StaffName varchar(255),
    ManagerID varchar(5),
    PRIMARY KEY (StaffID),
    FOREIGN KEY (ManagerID) REFERENCES Staff(StaffID)
);

CREATE TABLE Activity (
    ActivityID varchar(5),
    ActivityName varchar(255),
    ActivityCost decimal(5,2),
    ActivityType varchar(1)
);

CREATE TABLE ActivityBooking (
    ActivityID varchar(5),
    ReservationID varchar(5),
    ActivityTime timestamp,
    NumPeople int,
    GuideID varchar(5),
    CONSTRAINT activity_booking_pk PRIMARY KEY (ActivityID, ReservationID, ActivityTime),
    FOREIGN KEY (ActivityID) REFERENCES Activity(ActivityID),
    FOREIGN KEY (ReservationID) REFERENCES Reservation(ReservationID),
    FOREIGN KEY (GuideID) REFERENCES Staff(StaffID)
);

INSERT INTO ACTIVITY VALUES ('A01', 'Kayaking', 120.00, 'B');
INSERT INTO ACTIVITY VALUES ('A02', 'Cycling', 50.00, 'O');
INSERT INTO ACTIVITY VALUES ('A03', 'Carrom', 20.00, 'I');
INSERT INTO ACTIVITY VALUES ('A06', 'Chess', 20.00, 'I');
INSERT INTO ACTIVITY VALUES ('A12', 'Football', 40.00, 'O');

INSERT INTO STAFF VALUES('S1', 'Chris Hemsworth', null);
INSERT INTO STAFF VALUES('S2', 'Richard Dawkins', 'S1');
INSERT INTO STAFF VALUES('S3', 'Richard Dawkins', 'S1');
INSERT INTO STAFF VALUES('S4', 'Robert Downey', null);
INSERT INTO STAFF VALUES('S5', 'Christian Bale', 'S4');

INSERT INTO ACTIVITYBOOKING VALUES('A01', 'R321', to_timestamp('12/05/2020 13:30', 'mm/dd/yyyy hh24:mi'), 4, 'S2');
INSERT INTO ACTIVITYBOOKING VALUES('A02', 'R322', to_timestamp('10/10/2020 11:30', 'mm/dd/yyyy hh24:mi'), 3, 'S3');
INSERT INTO ACTIVITYBOOKING VALUES('A03', 'R323', to_timestamp('02/10/2020 16:30', 'mm/dd/yyyy hh24:mi'), 4, 'S2');
INSERT INTO ACTIVITYBOOKING VALUES('A06', 'R324', to_timestamp('04/18/2020 12:30', 'mm/dd/yyyy hh24:mi'), 4, 'S1');
INSERT INTO ACTIVITYBOOKING VALUES('A12', 'R325', to_timestamp('03/19/2020 15:30', 'mm/dd/yyyy hh24:mi'), 5, 'S1');

-- Task 14

SELECT RESERVATIONID, 
    (
        SELECT (VILLARESERVATION.DATETO-VILLARESERVATION.DATEFROM)* VILLACOSTPERDAY
        FROM VILLA
        WHERE VILLARESERVATION.VILLAID = VILLA.VILLAID 
    ) AS TOTAL_AMOUNT
FROM VILLARESERVATION
WHERE 10000 <= 
    (
        SELECT (VILLARESERVATION.DATETO-VILLARESERVATION.DATEFROM)* VILLACOSTPERDAY
        FROM VILLA
        WHERE VILLARESERVATION.VILLAID = VILLA.VILLAID 
    )
;

-- Task 15

SELECT CUSTOMERNAME
FROM CUSTOMER
WHERE CUSTOMERID = 
    (
        SELECT CUSTOMERID
        FROM RESERVATION
        WHERE RESERVATION.CUSTOMERID = CUSTOMER.CUSTOMERID
        AND RESERVATION.RESERVATIONID = 
            (
                SELECT RESERVATIONID
                FROM ACTIVITYBOOKING
                WHERE ACTIVITYBOOKING.RESERVATIONID = RESERVATION.RESERVATIONID
                AND ACTIVITYBOOKING.ACTIVITYID = 
                (
                    SELECT A1.ACTIVITYID
                    FROM ACTIVITY A1
                    WHERE ACTIVITYBOOKING.ACTIVITYID = A1.ACTIVITYID
                    AND A1.ACTIVITYTYPE = 'O'
                    AND A1.ACTIVITYCOST < 
                        (
                            SELECT AVG(A2.ACTIVITYCOST)
                            FROM ACTIVITY A2
                            WHERE A1.ACTIVITYTYPE = 'O'
                        )
                )
            )
    )
;

-- SECTION-THREE

/* Insert table creation and data for populating the tables */

CREATE TABLE SupportStaff (
    RoasterID varchar(5),
    ActivityID varchar(5),
    ReservationID varchar(5),
    ActivityTime timestamp,
    StaffID varchar(5),
    HoursNeeded int,
    PRIMARY KEY (RoasterID),
    FOREIGN KEY (ActivityID, ReservationID, ActivityTime) REFERENCES ActivityBooking(ActivityID, ReservationID, ActivityTime),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

INSERT INTO SUPPORTSTAFF VALUES ('R2351', 'A01', 'R321', to_timestamp('12/05/2020 13:30', 'mm/dd/yyyy hh24:mi'), 'S1', 4);
INSERT INTO SUPPORTSTAFF VALUES ('R2352', 'A02', 'R322', to_timestamp('10/10/2020 11:30', 'mm/dd/yyyy hh24:mi'), 'S2', 2);
INSERT INTO SUPPORTSTAFF VALUES ('R2353', 'A03', 'R323', to_timestamp('02/10/2020 16:30', 'mm/dd/yyyy hh24:mi'), 'S3', 1);
INSERT INTO SUPPORTSTAFF VALUES ('R2354', 'A06', 'R324', to_timestamp('04/18/2020 12:30', 'mm/dd/yyyy hh24:mi'), 'S1', 4);
INSERT INTO SUPPORTSTAFF VALUES ('R2355', 'A12', 'R325', to_timestamp('03/19/2020 15:30', 'mm/dd/yyyy hh24:mi'), 'S5', 3);

-- Task 16

SELECT 
    (
        SELECT ( 
                SELECT CUSTOMERNAME
                FROM CUSTOMER 
                WHERE RESERVATION.CUSTOMERID = CUSTOMER.CUSTOMERID
                )
        FROM RESERVATION 
        WHERE RESERVATION.RESERVATIONID = ACTIVITYBOOKING.RESERVATIONID 
    ) AS CUSTOMERNAME,
    ( 
        SELECT ACTIVITYNAME 
        FROM ACTIVITY 
        WHERE ACTIVITYBOOKING.ACTIVITYID = ACTIVITY.ACTIVITYID 
    ) AS ACTIVITYNAME,
    (
        SELECT STAFFNAME
        FROM STAFF
        WHERE STAFF.STAFFID = ACTIVITYBOOKING.GUIDEID
        AND STAFF.STAFFID = ANY(STAFF.MANAGERID)
    ) AS GUIDENAME
FROM ACTIVITYBOOKING
WHERE EXTRACT(HOUR FROM ACTIVITYTIME) >=12 AND EXTRACT(HOUR FROM ACTIVITYTIME) <= 16
;

-- Task 17

SELECT S1.STAFFNAME, 
(
    SELECT S2.STAFFNAME
    FROM STAFF S2
    WHERE S1.MANAGERID = S2.STAFFID
    AND EXISTS 
    (
        SELECT COUNT(S3.STAFFID)
        FROM STAFF S3
        WHERE S3.MANAGERID IS NOT NULL
        GROUP BY S3.MANAGERID
        HAVING COUNT(S3.STAFFID)>=2
    )
) AS MANAGERNAME
FROM STAFF S1
WHERE (
        SELECT S2.STAFFNAME
    FROM STAFF S2
    WHERE S1.MANAGERID = S2.STAFFID
    AND EXISTS 
        (
            SELECT COUNT(S3.STAFFID)
            FROM STAFF S3
            WHERE S3.MANAGERID IS NOT NULL
            GROUP BY S3.MANAGERID
            HAVING COUNT(S3.STAFFID)>=2
        )
    ) IS NOT NULL;


-- SECTION-FOUR

/* Insert table creation and data for populating the tables */

CREATE TABLE Package (
    PackageActivityID varchar(5),
    ChildActivityID varchar(5),
    CONSTRAINT package_pk PRIMARY KEY (PackageActivityID, ChildActivityID),
    FOREIGN KEY (PackageActivityID) REFERENCES Activity(ActivityID),
    FOREIGN KEY (ChildActivityID) REFERENCES Activity(ActivityID)
);

INSERT INTO PACKAGE VALUES('A01', 'A06');
INSERT INTO PACKAGE VALUES('A01', 'A12');
INSERT INTO PACKAGE VALUES('A02', 'A03');
INSERT INTO PACKAGE VALUES('A03', 'A06');
INSERT INTO PACKAGE VALUES('A03', 'A12');

-- Task 18

SELECT ACTIVITYID,RESERVATIONID,ACTIVITYTIME, 
    (
        SELECT ACTIVITYNAME
        FROM ACTIVITY
        WHERE ACTIVITYBOOKING.ACTIVITYID = ACTIVITY.ACTIVITYID
    ) AS ACTIVITYNAME,
    (
        SELECT STAFFNAME
        FROM STAFF
        WHERE STAFF.STAFFID = ACTIVITYBOOKING.GUIDEID
    ) AS GUIDENAME
FROM ACTIVITYBOOKING;

-- Task 19

SELECT DISTINCT(PACKAGEACTIVITYID), 
    (
        SELECT ACTIVITYNAME FROM ACTIVITY
        WHERE ACTIVITY.ACTIVITYID = PACKAGE.PACKAGEACTIVITYID
    ) AS PACKAGEACTIVITYID,
    (
        SELECT ACTIVITYCOST FROM ACTIVITY
        WHERE ACTIVITY.ACTIVITYID = PACKAGE.PACKAGEACTIVITYID
    ) AS ACTIVITYCOST,
    (
        SELECT ACTIVITYID
        FROM ACTIVITY
        WHERE ACTIVITY.ACTIVITYID = PACKAGE.CHILDACTIVITYID
    ) AS CHILDACTIVITYID,
    (
        SELECT ACTIVITYNAME FROM ACTIVITY
        WHERE ACTIVITY.ACTIVITYID = PACKAGE.CHILDACTIVITYID
    ) SUBACTIVITYNAME,
    (
        SELECT ACTIVITYCOST FROM ACTIVITY
        WHERE ACTIVITY.ACTIVITYID = PACKAGE.CHILDACTIVITYID
    ) SUBACTIVITYCOST
FROM PACKAGE
WHERE (
        SELECT ACTIVITYCOST FROM ACTIVITY
        WHERE ACTIVITY.ACTIVITYID = PACKAGE.CHILDACTIVITYID
    ) = 
    (
        SELECT MIN(ACTIVITYCOST) FROM ACTIVITY
        GROUP BY PACKAGE.CHILDACTIVITYID
    )
;

-- Task 20 

SELECT RESERVATIONID, 
    (
        SELECT ACTIVITY.ACTIVITYCOST*ACTIVITYBOOKING.NUMPEOPLE
        FROM ACTIVITY
        WHERE ACTIVITYBOOKING.ACTIVITYID = ACTIVITY.ACTIVITYID
    ) ACTIVITYCOST
FROM ACTIVITYBOOKING;
