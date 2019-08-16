--Chhorvoleak Heng, 102306496
/*Task1-Convert ERD to Relational Schema

TOUR(TourName, Description)
    PK: (TourName)

CLIENT(ClientId, Surname, GivenName,Gender)
    PK: (ClientId)

EVENT(TourName,EventMonth,EventDay,EventYear,EventFee)
    PK: (TourName,EventMonth,EventDay,EventYear)
    FK: (TourName) REFERECNCES TOUR

BOOKING(ClientId,TourName,EventMonth,EventDay,EventYear,Payment,DateBooked)
    PK: (ClientId,TourName,EventMonth,EventDay,EventYear)
    FK1: (ClientId) REFERENCES CLIENT
    FK2: (TourName,EventMonth,EventDay,EventYear) REFERENCES EVENT
*/
--Task2
DROP TABLE IF EXISTS BOOKING;
DROP TABLE IF EXISTS EVENT;
DROP TABLE IF EXISTS CLIENT;
DROP TABLE IF EXISTS TOUR;

CREATE TABLE TOUR (TourName NVARCHAR(100)
, Description NVARCHAR(500)
, PRIMARY KEY (TourName)
);

CREATE TABLE CLIENT (ClientId NUMERIC
, Surname NVARCHAR(100) NOT NULL
, GivenName NVARCHAR(100) NOT NULL
, Gender NVARCHAR(1)
, CHECK (Gender in ('M','F','I'))
, PRIMARY KEY(ClientId)
);

CREATE TABLE EVENT (TourName NVARCHAR(100)
, EventMonth NVARCHAR(3)
, EventDay NUMERIC
, EventYear NUMERIC
, EventFee MONEY NOT NULL
, CHECK (EventMonth in ('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'))
, CHECK (EventDay>=1 AND EventDay<=31)
, CHECK (LEN(EventYear)=4)
, CHECK (EventFee>0)
, PRIMARY KEY (TourName,EventMonth,EventDay,EventYear)
, FOREIGN KEY (TourName) REFERENCES TOUR

);

CREATE TABLE BOOKING (ClientId NUMERIC
, TourName NVARCHAR(100)
, EventMonth NVARCHAR(3)
, EventDay NUMERIC
, EventYear NUMERIC
, Payment MONEY
, DateBooked DATE NOT NULL
, CHECK (EventMonth in ('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'))
, CHECK (EventDay>=1 AND EventDay<=31)
, CHECK (LEN(EventYear)=4)
, CHECK (Payment>0)
, PRIMARY KEY(ClientId,TourName,EventMonth,EventDay,EventYear)
, FOREIGN KEY(ClientId) REFERENCES CLIENT
, FOREIGN KEY(TourName,EventMonth,EventDay,EventYear) REFERENCES EVENT

);

--Task3

INSERT INTO TOUR(TourName,[Description]) 
VALUES('North','Tour of wineries and outlets of the Bedigo and Castlemaine region');
INSERT INTO TOUR(TourName,[Description]) 
VALUES('South','Tour of wineries and outlets of Mornington Penisula');
INSERT INTO TOUR(TourName,[Description]) 
VALUES('West','and Otways region');

INSERT INTO CLIENT(ClientId,Surname,GivenName,Gender) 
VALUES(1,'Price','Taylor','M');
INSERT INTO CLIENT(ClientId,Surname,GivenName,Gender) 
VALUES(2,'Gamble','Ellyse','I');
INSERT INTO CLIENT(ClientId,Surname,GivenName,Gender) 
VALUES(3,'Tan','Tilly','F');
INSERT INTO CLIENT(ClientId,Surname,GivenName,Gender)
VALUES(102306496,'Heng','Chhorvoleak','F');

INSERT INTO EVENT(TourName,EventMonth,EventDay,EventYear,EventFee)
VALUES('North','Jan',9,2016,200);
INSERT INTO EVENT(TourName,EventMonth,EventDay,EventYear,EventFee)
VALUES('South','Jan',16,2016,225);
INSERT INTO EVENT(TourName,EventMonth,EventDay,EventYear,EventFee)
VALUES('West','Feb',13,2016,200);
INSERT INTO EVENT(TourName,EventMonth,EventDay,EventYear,EventFee)
VALUES('North','Feb',13,2016,225);

INSERT INTO BOOKING(ClientId,TourName,EventMonth,EventDay,EventYear,Payment,DateBooked)
VALUES(1,'North','Jan',9,2016,200,'2015-10-12');
INSERT INTO BOOKING(ClientId,TourName,EventMonth,EventDay,EventYear,Payment,DateBooked)
VALUES(2,'West','Feb',13,2016,200,'2015-10-13');
INSERT INTO BOOKING(ClientId,TourName,EventMonth,EventDay,EventYear,Payment,DateBooked)
VALUES(3,'North','Feb',13,2016,225,'2015-10-14');
INSERT INTO BOOKING(ClientId,TourName,EventMonth,EventDay,EventYear,Payment,DateBooked)
VALUES(102306496,'South','Jan',16,2016,225,'2015-10-15');

--Task4
---Query1
SELECT c.GivenName,c.Surname, t.TourName,t.[Description], e.EventYear,e.EventMonth,e.EventDay,e.EventFee,b.DateBooked,b.Payment
FROM ((BOOKING b 
INNER JOIN CLIENT c on b.ClientId=c.ClientId)
INNER JOIN EVENT e on b.TourName=e.TourName 
AND b.EventMonth=e.EventMonth 
AND b.EventDay=e.EventDay 
AND b.EventYear=e.EventYear
INNER JOIN TOUR t on e.TourName=t.TourName
);
---Query2
SELECT e.EventMonth,t.TourName
, count(e.EventMonth) AS 'Num of Bookings'
FROM ((BOOKING b 
INNER JOIN CLIENT c on b.ClientId=c.ClientId)
INNER JOIN EVENT e on b.TourName=e.TourName 
AND b.EventMonth=e.EventMonth 
AND b.EventDay=e.EventDay 
AND b.EventYear=e.EventYear
INNER JOIN TOUR t on e.TourName=t.TourName)
GROUP BY e.EventMonth, t.TourName
;
---Query3
SELECT * from BOOKING 
WHERE BOOKING.Payment>(SELECT AVG(BOOKING.Payment) from BOOKING);