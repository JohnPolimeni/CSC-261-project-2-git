select count(distinct User.userID) 
from User,Item 
where Item.userID= User.userID AND User.rating>1000;
