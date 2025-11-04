create table ProductSummary(
	SummaryID INT Primary Key,
    TotalQuantity INT
);

insert into ProductSummary (SummaryID,TotalQuantity)
select 1,
	   sum(quantity)
from Products;

select *
from ProductSummary;

delimiter //
create trigger AfterProductUpdateSummary
after update on Products
for each row
begin
	declare quantity_change int;
    
	if old.quantity <> new.quantity then
		set quantity_change = new.quantity - old.quantity;
    
		update ProductSummary
        set TotalQuantity = TotalQuantity + quantity_change
        where SummaryID = 1;
	end if;
end //
delimiter ;

DELIMITER //

SELECT 'Before UPDATE' AS StatusUpdate,
	   TotalQuantity
FROM ProductSummary;

update Products
set quantity = 70
where productID = 2;

select 'After UPDATE' as StatusUpdate,
	   TotalQuantity
from ProductSummary;