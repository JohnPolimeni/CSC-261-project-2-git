Select count(*) 
From( 
	select distinct a.userID as user1, b.userID as user2 
	From Bid a, Bid b 
	where a.itemID= b.itemID and a.userID < b.userID) as Q1;
