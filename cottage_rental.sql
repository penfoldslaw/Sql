CREATE TABLE Region (
  RegionID int NOT NULL IDENTITY (1, 1),
  RegionName char(70) NOT NULL,
  CONSTRAINT Region_PK PRIMARY KEY (RegionID)
);

CREATE TABLE Cottage (
  CottageID int NOT NULL IDENTITY (1, 1),
  RegionID int NOT NULL,
  CottageName varchar(100) NULL,
  NumberOfBedroom int NULL,
  CottageAddress varchar(100) NOT NULL,
  CottagePostcode int NOT NULL,
  CottageCity varchar(100) NOT NULL,
  CottageState varchar(100) NOT NULL,
  MaxiumOccupancy int not null,
  CONSTRAINT Cottage_PK PRIMARY KEY (CottageID),
  CONSTRAINT Cott_Reg_FK FOREIGN KEY (RegionID)
  REFERENCES Region (RegionID) ON UPDATE CASCADE
);

CREATE TABLE CottagePrice (
  CottageType varchar(100) NOT NULL,
  DefaultPrice int NOT NULL,
  CottageID int NOT NULL,
  SurgeStartDate date NOT NULL,
  SurgeEndDate date NOT NULL,
  SurgePrice int NOT NULL,
  CONSTRAINT CotP_Cott_FK FOREIGN KEY (CottageID)
  REFERENCES Cottage (CottageID) ON UPDATE CASCADE
);

CREATE TABLE Customers (
  CustomerID int NOT NULL IDENTITY (1, 1),
  CustomerFirstName varchar(255) NOT NULL,
  CustomerLastName varchar(255) NOT NULL,
  CustomerEmail char(255) NOT NULL,
  CustomerAddress varchar(255) NOT NULL,
  CustomerPostcode varchar(255) NOT NULL,
  CustomerCity varchar(255) NOT NULL,
  CustomerState varchar(255) NOT NULL,
  CustomerPhoneNumber varchar(60) not null,
  CONSTRAINT Customers_PK PRIMARY KEY (CustomerID)
);

CREATE TABLE Booking (
  BookingID int NOT NULL IDENTITY (1, 1),
  CottageID int NOT NULL,
  CustomerID int NOT NULL,
  CottageType varchar(100) NOT NULL,
  BookingDate date NOT NULL,
  BookingTime time NOT NULL,
  ArrivalDate date NOT NULL,
  DepartureDate date NOT NULL,
  NumberOfPeople int not null,
  CONSTRAINT Booking_PK PRIMARY KEY (BookingID),
  CONSTRAINT Book_Cott_FK FOREIGN KEY (CottageID) REFERENCES Cottage (CottageID) ON UPDATE CASCADE,
  CONSTRAINT Book_Cust_Fk FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID) ON UPDATE CASCADE
);


CREATE TABLE Payments (
  PaymentID int NOT NULL IDENTITY (1, 1),
  CustomerID int NOT NULL,
  BookingID int NOT NULL,
  Paymentamount numeric(10, 2) NOT NULL,
  Datepayed date NOT NULL,
  CONSTRAINT Payments_PK PRIMARY KEY (PaymentID),
  CONSTRAINT Pay_Book_FK FOREIGN KEY (BookingID) REFERENCES Booking (BookingID) ON UPDATE CASCADE,
  CONSTRAINT DF_Payments_BookingID DEFAULT 0 FOR BookingID
);



Insert into Region (RegionName)
Values ('Northeast'), ('Southwest'), ('West'), ('Southeast'), ('Midwest')


#scripting for importing cottage data
insert into Cottage (RegionID,CottageName,NumberOfBedroom,CottageAddress,CottagePostcode,CottageCity,CottageState, CottageType, MaximumOccupancy)
select RegionID,CottageName,NumberOfBed,CottageAddress,CottagePostcode,CottageCity,CottageState, CottageType, MaximumOccupancy from cottagecsv;

# scripting for importing CottagePrice data
insert into cottageprice (DefaultPrice, CottageID, SurgeStartDate, SurgeEndDate, SurgePrice)
select DefaultPrice, CottageID, SurgeStartDate, SurgeEndDate, SurgePrice from CottagePricecsv

#scripting for importing Customers data
insert into customers (CustomerFirstName,CustomerLastName,CustomerEmail,CustomerAddress,CustomerPostcode,CustomerCity,CustomerState,CustomerPhoneNumber)
select CustomerFirstName,CustomerLastName,CustomerEmail,CustomerAddress,CustomerPostcode,CustomerCity,CustomerState,Phone Number from customerscsv


#Scripting for importing Booking data
insert into Booking (CottageID, CustomerID, BookingDate, BookingTime, ArrivalDate, DepartureDate, NumberOfPeople)
select CottageID, CustomerID, BookingDate, BookingTime, ArrivalDate, DepartureDate, NumberOfPeople from bookingcsv 

#Scripting for importing payments data
insert into Payments (BookingID, Paymentamount, Datepayed)
select BookingID, Paymentamount, Datepayed from paymentscsv

);
