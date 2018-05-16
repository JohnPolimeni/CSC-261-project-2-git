select count(*)
 from (select Item.userID 
from Item,Category 
where Item.itemID = Category.itemID 
group by userID 
having count(distinct category) > 10) as Q1

