alter table Products
add LastUpdated datetime;

delimiter //
create trigger AfterProductUpdateSetDate
before update on Products
for each row
begin
	set new.LastUpdated = now();
end //
delimiter ;

select *
from Products;

update Products
set productName = 'Áo Sơ Mi'
where productID = 7;

