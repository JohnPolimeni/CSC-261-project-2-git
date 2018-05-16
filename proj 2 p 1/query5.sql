select count(distinct User.userID)
from User,Item,Bid 
where User.userID=Item.userID and Bid.userID=User.userID;