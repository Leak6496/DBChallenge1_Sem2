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


