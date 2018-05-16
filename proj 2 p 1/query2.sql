select Count(cat.itemID) from
	(Select itemID,count(itemID) as count 
	from Category 
	group by itemID)as cat 
where cat.count=4;