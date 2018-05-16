DROP TABLE if EXISTS User;
DROP TABLE if EXISTS Item;
DROP TABLE if EXISTS Category;
DROP TABLE if EXISTS Bid;
DROP TABLE if exists CurrentTime ;

create table User(
    userID varchar(50) NOT NULL,
    rating INT,
    country VARCHAR(60),
    location VARCHAR(60),
    PRIMARY KEY(userID)
);

create table Item(
    itemID int NOT NULL,
    name varchar(60),
    currently decimal,
     buy_price decimal,
    first_bod decimal
    started datetime,
    ends datetime,
    userID varchar(50),
    desctiption text,
    PRIMARY KEY(itemID),
    FOREIGN KEY (userID) REFERENCES User(userID)
);

create table Category(
    itemID int,
    category VARCHAR(60),
    CONSTRAINT constraint_category PRIMARY KEY(category,itemID),
    FOREIGN KEY (itemID) REFERENCES Item(itemID)
);

create table Bid(
    itemID int,
    userID varchar(50),
    time datetime,
    amount decimal(10,2),
    CONSTRAINT constraint_bid PRIMARY KEY(userID,itemID,time),
    FOREIGN KEY (userID) REFERENCES User(userID),
    FOREIGN KEY (itemID) REFERENCES Item(itemID)
);
CREATE TABLE CurrentTime (
        timeNow DATETIME NOT NULL) ;
INSERT INTO CurrentTime values ('2001-12-20 00:00:01') ;
SELECT timeNow FROM CurrentTime ;

LOAD DATA LOCAL INFILE "user.dat"
INTO TABLE User
FIELDS TERMINATED BY "<>";
LOAD DATA LOCAL INFILE "item.dat"
INTO TABLE Item
FIELDS TERMINATED BY "<>";
LOAD DATA LOCAL INFILE "category.dat"
INTO TABLE Category
FIELDS TERMINATED BY "<>";
LOAD DATA LOCAL INFILE "bid.dat"
INTO TABLE Bid
FIELDS TERMINATED BY "<>";



