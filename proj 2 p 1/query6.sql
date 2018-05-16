select count(distinct Category.category)
 from Category,
	(select itemID  
	from Bid  
	where Bid.amount>1000)as Q1 
where Q1.itemID=Category.itemID;