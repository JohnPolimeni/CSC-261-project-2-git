DROP TABLE if EXISTS User;
DROP TABLE if EXISTS Item;
DROP TABLE if EXISTS Category;
DROP TABLE if EXISTS Bid;

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
    currently float,
     buy_price float,
    first_bod float,
    started datetime,
    ends datetime,
    userID varchar(50),
    desctiption varchar(10000),
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
    amount float(10,2),
    CONSTRAINT constraint_bid PRIMARY KEY(userID,itemID,time),
    FOREIGN KEY (userID) REFERENCES User(userID),
    FOREIGN KEY (itemID) REFERENCES Item(itemID)
);

