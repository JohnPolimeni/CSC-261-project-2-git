
DROP TRIGGER IF EXISTS before_insert_bid;
DROP TRIGGER IF EXISTS after_insert_bid;
DROP TRIGGER IF EXISTS before_update_time;

DELIMITER //
CREATE TRIGGER before_insert_bid BEFORE INSERT ON Bid
FOR EACH ROW
BEGIN
	IF NEW.userID= ANY(
		select 
			userID 
		from 
			Item
		where	
			Item.itemID=NEW.itemID) 
	THEN
	CALL `Error1::A user cannot bid on an item they are also selling`;
		
	ELSEIF NEW.time= ANY(
		Select 
			Bid.time 
		from 
			Bid, Item 
		where 
			Bid.itemID=Item.itemID AND 
			Bid.itemID=NEW.itemID)
	THEN
	CALL `error2:No auction may have two bids at the exact same time.`;
	

	ELSEIF (NEW.time< ANY(
		Select 
			Item.started 
		from 
			Item
		where 
			NEW.itemID=Item.itemID))
	THEN
	CALL `error 3 cant bid before auction starts`;

	ELSEIF( NEW.time> ANY(
		select 
			Item.ends 
	 	from 
			Item
		where 
			NEW.itemID=Item.itemID))
	THEN
	CALL `error3: cant bid after auction ends`;
	
	ELSEIF(NEW.userID= ANY(
		select
			Bid.userID
		from
			Item,Bid
		where
			Bid.amount=NEW.amount AND Bid.userID=New.userID AND Bid.itemID=Item.itemID))
	THEN
	CALL `error 4:No user can make bid of same amount to same item>once`;


	ELSEIf(New.amount<= ANY(
		Select
			Item.currently
		from
		Item
		where
		New.itemID=Item.itemID))
	THEN
	CALL `error 5 this bid is less or equal to the current amount`;

	ELSEIF(NEW.time<>(
		Select 
			timeNow
		from 
			CurrentTime))
	THEN
	CALL `error 6 The bid must be placed at the current time`;
	END IF;
END;//

CREATE TRIGGER after_insert_bid AFTER INSERT ON Bid
FOR EACH ROW
BEGIN
	If(NEW.amount<> ANY(
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

CREATE TRIGGER before_update_time BEFORE UPDATE ON CurrentTime
FOR EACH ROW
BEGIN
	If(NEW.timeNow< (
		Select
			CurrentTime.timeNow
		from
			CurrentTime))
	THEN
	CALL `error 8;time can only move in one direction`;
	END IF;
END;//

DELIMITER ;
