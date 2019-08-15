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

