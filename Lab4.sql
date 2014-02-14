--Q1

select city
from agents 
where aid in ( 
	select aid
	from orders
	where cid in(
		select cid
		from customers
		where name = 'Basics')
		      );


--Q2

select pid
from products 
where pid in (
	select pid
	from orders
	where cid in (
		select cid
		from customers
		where city = 'Kyoto')
		);

--Q3

select cid, name
from customers
where cid NOT IN (
		select cid 
		from orders 
		where aid = 'a03')
	order by cid ASC;


--Q4

select cid, name
from customers
where cid in(
	select cid
	from orders
	where pid IN(
		select pid
		from products
		where pid = 'p01' OR pid = 'p07'
		)
	     )
	     ORDER BY cid ASC;


--Q5

select pid
from products
where pid in(
	select pid
	from orders
	where cid in(
		select cid
		from orders
		where aid = 'a03'
		)
	) ORDER BY pid ASC;


--Q6

select name, discount
from customers
where cid IN (
	select cid
	from orders
	where aid IN(
		select aid 
		from agents
		where city = 'Dallas' OR city = 'Duluth'
		)
	)ORDER BY name ASC;


--Q7


select *
from customers
where  city != 'Kyoto' 
	AND city != 'Dallas' 
	AND discount IN (
			select discount
			from customers
			where discount IN(
				select discount
				from customers
				where city = 'Dallas' 
				or city = 'Kyoto'
				)
			) ORDER BY cid ASC;