create database if not exists cs125_fd;
use cs125_fd;

create table flights(
	flno int primary key,
	ffrom varchar(255),
	fto varchar(255),
	distance int,
	departs time,
	arrives time,
	price int
);

create table aircraft(
	aid int primary key,
	aname varchar(255),
	cruising_range int
);

create table employees(
	eid int primary key,
	ename varchar(255),
	salary int
);

create table certified(
	eid int,
	aid int,
	primary key(eid,aid),
	foreign key(eid) references employees(eid) on delete cascade on update cascade,
	foreign key(aid) references aircraft(aid) on delete cascade on update cascade
);

insert into flights values
	(1,'Bengaluru','New Delhi',500,'6:00','9:00',5000),
    (2,'Bengaluru','Chennai',300,'7:00','8:30',3000),
    (3,'Trivandrum','New Delhi',800,'8:00','11:30',6000),
    (4,'Bengaluru','Frankfurt',10000,'6:00','23:30',50000),
    (5,'Kolkata','New Delhi',2400,'11:00','3:30',9000),
    (6,'Bengaluru','Frankfurt',8000,'9:00','23:00',40000);
    
    select*from flights

insert into aircraft values
	(1,'Airbus',2000),
    (2,'Boeing',700),
    (3,'JetAirways',550),
    (4,'Indigo',5000),
    (5,'Boeing',4500),
    (6,'Airbus',2200);
    
    select*from aircraft

insert into employees values
	(101,'Avinash',50000),
    (102,'Lokesh',60000),
    (103,'Rakesh',70000),
    (104,'Santhosh',82000),
    (105,'Tilak',5000);
    
    select*from employees

insert into certified values
	(101,2),
    (101,4),
    (101,5),
    (101,6),
    (102,1),
    (102,3),
    (102,5),
    (103,2),
    (103,3),
    (103,5),
    (103,6),
    (104,6),
    (104,1),
    (104,3),
    (105,3);
    
    select*from certified 
    
    
select a.aname
from aircraft a, certified c, employees e
where a.aid = c.aid and c.eid = e.eid
	and e.salary > 80000;
    
select aname
from aircraft
where aid not in (
	select aid
	from (
		select a.aid, min(e.salary) as salary
		from aircraft a, certified c, employees e
		where a.aid = c.aid and c.eid = e.eid
		group by a.aid
	) innerT
	where salary <= 80000
);
    
select c.eid, max(a.cruising_range) 
from certified c, aircraft a 
where c.aid=a.aid
group by eid 
having count(eid) >=3;

select ename, salary
from employees
where salary < (
	select min(price)
    from flights
    where ffrom = "Bengaluru" and fto = "Frankfurt"
);

select a.aid, a.aname, avg(e.salary)
from aircraft a, employees e, certified c
where a.aid = c.aid and c.eid = e.eid
	and cruising_range >= 1000
group by a.aid;


select ename from employees
where eid in (
	select c.eid
    from certified c, aircraft a
    where c.aid= a.aid and aname = "Boeing"
);


select aid, aname
from aircraft
where cruising_range >= (
	select distance
    from flights
    where ffrom = "Bengaluru" and fto = "New Delhi"
);