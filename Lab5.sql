----Lab 5

--Q1

select agents.city
from agents, orders, customers
where orders.aid = agents.aid
	AND 
      orders.cid = customers.cid
        AND
      customers.name = 'Basics'
;
	
--Q2

select orders.pid
from customers, orders
where customers.city = 'Kyoto'
	AND orders.cid = customers.cid
order by orders.pid;


--Q3


select name
from customers
where cid NOT IN (
		select cid
		from orders)
;

--Q4

select distinct customers.name
from customers
left join 
     orders
	on customers.cid = orders.cid
where orders.cid is null;


--Q5

select DISTINCT customers.name AS CUSTName, agents.name AS AgentName
from customers, agents, orders
where customers.city = agents.city
	AND (customers.cid = orders.cid 
	AND agents.aid = orders.aid);


--Q6

select customers.name AS CUSTName, agents.name AS AgentName, customers.city, agents.city
from customers, agents
where customers.city = agents.city;


--Q7


select
   customers.name,
   customers.city,
   sum(products.quantity)
from
   customers
   inner join products on products.city = customers.city
group by
   customers.name,
   customers.city
 order by sum(products.quantity)
 limit 1
---------------------------------------------------------