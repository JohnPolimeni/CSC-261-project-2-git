
-- DROP TRIGGER IF EXISTS before_insert_bid;
-- DELIMITER //
-- CREATE TRIGGER before_insert_bid BEFORE INSERT ON Bid
-- FOR EACH ROW
-- BEGIN
-- 	IF NEW.userID=(select userID from Item where Item.itemID=NEW.itemID) 
-- 	THEN
-- 	CALL `Error1::A user cannot bid on an item they are also selling`;
-- 	END IF;
	
-- 	IF NEW.time= (
-- 		Select 
-- 			Bid.time 
-- 		from 
-- 			Bid, Item 
-- 		where 
-- 			Bid.itemID=Item.itemID AND 
-- 			Bid.itemID=NEW.itemID)
-- 	THEN
-- 	CALL `error2:No auction may have two bids at the exact same time.`;
-- 	END IF;

-- 	IF (NEW.time< (
-- 		Select 
-- 			Item.started 
-- 		from 
-- 			Item
-- 		where 
-- 			NEW.itemID=Item.itemID))
-- 	THEN
-- 	call`error 3 cant bid before auction starts`;

-- 	ELSEIF( NEW.time> (
-- 		select 
-- 			Item.ends 
-- 	 	from 
-- 			Item
-- 		where 
-- 			NEW.itemID=Item.itemID))
-- 	THEN
-- 	CALL `error3: cant bid after auction ends`;
-- 	END IF;

-- 	IF(NEW.userID= (
-- 		select
-- 			Bid.userID
-- 		from
-- 			Item,Bid
-- 		where
-- 			Bid.amount=NEW.amount AND Bid.userID=New.userID AND Bid.itemID=Item.itemID))
-- 	THEN
-- 	CALL `error 4`;
-- 	END IF;

-- 	CREATE TRIGGER before_insert_bid BEFORE INSERT ON Bid
-- FOR EACH ROW
-- BEGIN
-- 	If(New.amount<= (
-- 		Select
-- 			Item.currently
-- 		from
-- 		Item
-- 		where
-- 		New.itemID=Item.itemID))
-- 	THEN
-- 	CALL `error 5 this bid is less or equal to the current amount`;
-- 	END IF;
-- END;//

-- CREATE TRIGGER after_insert_bid AFTER INSERT ON Bid
-- FOR EACH ROW
-- BEGIN
-- 	If(NEW.amount<> (
-- 		Select
-- 			Item.currently
-- 		from 
-- 			Item
-- 		where
-- 			Item.itemID=NEW.itemID))
-- 	THEN
-- 	UPDATE 	Item
-- 	Set     Item.currently=New.amount
-- 	where 	Item.itemID=New.itemID;
-- 	END IF;



-- DELIMITER ;



CREATE TRIGGER before_update_time BEFORE UPDATE CurentTime
FOR EACH ROW
BEGIN
	If(NEW.timeNow< (
		Select
			CurrentTime.timeNow
		from
			CurentTime))
	THEN
	CALL `error 8;time can only move in one direction`;
	END IF;
END;//


DROP TRIGGER IF EXISTS before_insert_bid;
DROP TRIGGER IF EXISTS after_insert_bid;
DROP TRIGGER IF EXISTS before_update_time;

DROP TRIGGER IF EXISTS before_insert_bid;
DELIMITER //
CREATE TRIGGER before_insert_bid BEFORE INSERT ON Bid
FOR EACH ROW
BEGIN
	IF NEW.userID=(select userID from Item where Item.itemID=NEW.itemID) 
	THEN
	CALL `Error1::A user cannot bid on an item they are also selling`;
		
	ELSEIF NEW.time= (
		Select 
			Bid.time 
		from 
			Bid, Item 
		where 
			Bid.itemID=Item.itemID AND 
			Bid.itemID=NEW.itemID)
	THEN
	CALL `error2:No auction may have two bids at the exact same time.`;
	

	ELSEIF (NEW.time< (
		Select 
			Item.started 
		from 
			Item
		where 
			NEW.itemID=Item.itemID))
	THEN
	call`error 3 cant bid before auction starts`;

	ELSEIF( NEW.time> (
		select 
			Item.ends 
	 	from 
			Item
		where 
			NEW.itemID=Item.itemID))
	THEN
	CALL `error3: cant bid after auction ends`;
	
	ELSEIF(NEW.userID= (
		select
			Bid.userID
		from
			Item,Bid
		where
			Bid.amount=NEW.amount AND Bid.userID=New.userID AND Bid.itemID=Item.itemID))
	THEN
	CALL `error 4`;

	ELSEIf(New.amount<= (
		Select
			Item.currently
		from
		Item
		where
		New.itemID=Item.itemID))
	THEN
	CALL `error 5 this bid is less or equal to the current amount`;

	Update NEW.time
	set NEW.time=CurrentTime.timeNow
	CALL `error 6`;
	END IF;
END;//

CREATE TRIGGER after_insert_bid AFTER INSERT ON Bid
FOR EACH ROW
BEGIN
	If(NEW.amount<> (
		Select
			Item.currently
		from 
			Item
		where
			Item.itemID=NEW.itemID))
	THEN
	UPDATE 	Item
	Set     Item.currently=New.amount
	where 	Item.itemID=New.itemID;
	END IF;
END;//

DELIMITER ;

-- Error 1 test
insert into Bid values(1043374545, 'rulabula', '2001-12-07 20:52:43', 16.20);

-- Error 2 test
insert into Bid values(1496021639,'john','2001-12-15 22:30:32',67);

-- Error 4 test
insert into Bid values(1044707198, 'm34c', '2001-12-08 10:19:11', 21.49)

-- error 5 test
-- insert into Bid values(1044707198, '!peanut', '2001-12-08 10:19:19', 1.00);
-- mysql> insert into Bid values(1496021639,'john','2001-12-15 22:30:33',3);
 
--  error 7 test
 insert into Bid values(1048023972, '!peanut', '2001-12-20 00:00:01', 69.69);


-- Error 8 test
update CurrentTime set timeNow = '2000-01-01 00:00:01';
