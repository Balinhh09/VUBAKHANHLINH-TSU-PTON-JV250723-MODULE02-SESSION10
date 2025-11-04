delimiter //
create trigger BeforeProductDelete
before delete on Products
for each row
begin
	if old.quantity > 10 then
    signal sqlstate '45000' set message_text = 'Không thể xoá sản phẩm có số lượng lớn hơn 10!';
    end if;
end //
delimiter ;

delete from Products
where productID = 3;

delete from Products 
where productID = 5;

