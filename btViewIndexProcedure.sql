create table `products` (
  `id` int not null,
  `productcode` int not null,
  `productname` varchar(100) not null,
  `productprice` double not null,
  `productamount` varchar(100) not null,
  `productdescription` text,
  `productstatus` varchar(100) not null
) engine=innodb default charset=utf8mb4 collate=utf8mb4_0900_ai_ci

create unique index products_productcode_idx using btree on bt_view_index_store_procedure.products (productcode);
create index products_productname_idx using btree on bt_view_index_store_procedure.products (productname,productprice);

explain select * from bt_view_index_store_procedure.products p where productcode = 22;

-- view
create or replace view bt_view_index_store_procedure.product_view
as 
select productcode , productname , productprice , productstatus 
from products p;

select * from product_view pv ;

-- edit view
create or replace view product_view as
select productcode , productname , productprice
from products;

drop view product_view ;

-- create display
create procedure bt_view_index_store_procedure.display_all()
begin
	select * from products;
end

call display_all(); 

-- create add
create procedure add_product(in id int, in productcode int, in productname varchar(100), in productprice double, in productamount varchar(100), in productdescription text, in productstatus varchar(100))
begin
	insert into products (id, productcode, productname, productprice, productamount, productdescription, productstatus)
	values (id, productcode, productname, productprice, productamount, productdescription, productstatus);
	commit;
end

call add_product (5, 55, 'test5', 55.55, 'test5test5', 'khong co', 'het hang');

-- create edit
create procedure edit_product
(
in id int,
in productcode int, 
in productname varchar(100), 
in productprice double, 
in productamount varchar(100), 
in productdescription text, 
in productstatus varchar(100)
)
begin
	update products 
	set productcode = productcode, 
		productname = productname, 
		productprice = productprice, 
		productamount = productamount, 
		productdescription = productdescription, 
		productstatus = productstatus
	where products.id = id;
	commit;
end

call edit_product(1, 66, 'test6', 66.66, 'test6test6','' , 'con hang');

-- create delete
create procedure delete_product (in id int)
begin
	delete from products where products.id = id;
	commit;
end

call delete_product (3);