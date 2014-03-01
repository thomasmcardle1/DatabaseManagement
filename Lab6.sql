----Q1

select c.name,
	c.city
from customers c
where c.city IN (
	select p.city
	from products p
	group by p.city
	having sum(p.quantity) > 1
	order by sum(p.quantity) desc
	limit 1
	)

---Q2
select c.name,
	c.city
from customers c
where c.city IN (
	select p.city
	from products p
	group by p.city
	having count(p.quantity) > 1
	order by count(p.quantity) desc
	limit 1)

 
 --Q3

select name, pid, priceUSD
from products
where priceUSD > 
	(select avg(priceUSD)
	from products)


--Q4

select customers.name, orders.pid, orders.dollars
from customers, orders
where customers.cid = orders.cid
order by orders.dollars desc


--Q5

select customers.name, sum(orders.dollars)
from customers
inner join orders
	on customers.cid = orders.cid
group by customers.name
order by sum(orders.dollars) desc

--Q6

select customers.name AS CUSTOMER_NAME, products.name AS PRODUCTS_NAME
from agents, customers, products, orders
where agents.city = 'New York'
	AND orders.aid = agents.aid
	AND products.pid = orders.pid
	AND customers.cid = orders.cid


--Q7

select 	o.ordno,
	c.name,
	p.pid, 
	((o.qty * p.priceUSD) - ((o.qty * p.priceUSD)*(c.discount / 100))) as ACTUAL_COST ,
	o.dollars AS PRICE_PAID
from products p
	left join orders o
		on p.pid = o.pid
	left join customers c
		on c.cid = o.cid
	where ((o.qty * p.priceUSD) - ((o.qty * p.priceUSD)*(c.discount / 100))) != 
		o.dollars
	group by p.pid, c.name, o.ordno, c.discount
	order by o.ordno