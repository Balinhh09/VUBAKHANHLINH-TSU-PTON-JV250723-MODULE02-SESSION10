create database InventoryManagement;
use InventoryManagement;

create table Products(
	productID int primary key auto_increment,
    productName varchar(100),
    quantity int
);

insert into Products(productName,quantity) values
('Áo',21),
('Quần',42),
('Giày',35),
('Dép',28),
('Nón',7),
('Tất',14),
('Trang Sức',49);

create table InventoryChanges(
	changeID int primary key auto_increment,
    productID int,
    oldQuantity int,
    newQuantity int,
    changeDate datetime,
    
    foreign key (productID) references Products(productID)
);

delimiter //
create trigger AfterProductUpdate
after update on Products
for each row
begin 
	if old.quantity <> new.quantity then
		insert into InventoryChanges(
			productID,
			oldQuantity,
			newQuantity,
			changeDate
		)
        values(
			old.productID,
            old.quantity,
            new.quantity,
            now()
		);
	end if;
end //
delimiter ;
    
update Products 
set quantity = 56
where productID = 1;

update Products
set quantity = 63
where productID = 2;
   
select *
from InventoryChanges;
   
select *
from Products;
    
SHOW TRIGGERS;
