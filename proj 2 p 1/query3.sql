select itemID
from Item
where Item.buy_price=(
	select max(buy_price)
	from Item)
	