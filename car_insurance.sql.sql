show databases;
create database insurance_database;
use insurance_database;

create table person
(
driver_id varchar(10),
driver_name varchar(20),
address varchar(20),
primary key(driver_id)
);
desc person;
create table car
(
reg_num varchar(10),
model varchar(10),
car_year int,
primary key(reg_num)
);
desc car;
create table accident
(
report_num int,
accident_date date,
location varchar(20),
primary key(report_num)
);
desc accident;
create table owns
(
driver_id varchar(10),
reg_num varchar(10),
primary key(driver_id,reg_num),
foreign key(driver_id)references person(driver_id),
foreign key(reg_num)references car(reg_num)
);
desc owns;
create table participated
(
driver_id varchar(10),
reg_num varchar(10),
report_num int,
damage_amount int,
primary key(driver_id,reg_num,report_num),
foreign key(driver_id)references person(driver_id),
foreign key(reg_num)references car(reg_num),
foreign key(report_num)references accident(report_num)
);
desc participated;
insert into person
values('a01','richard','srinivas nagar'),('a02','pradeep','rajajinagar'),('a03','smith','ashok nagar'),('a04','venu','n r colony'),('a05','john','hanumath nagar');
insert into car
values('KA052250','INDICA','1990'),('KA031181','LANCER','1957'),('KA095477','TOYOTA','1998'),('KA053408','HONDA','2008'),('KA041702','AUDI','2005');
SELECT * FROM CAR;
INSERT INTO ACCIDENT
VALUES('11','2003-01-01','MYSORE ROAD'),('12','2004-02-02','SOUTHEND CIRCLE'),('13','2003-01-21','BULL TEMPLE ROAD'),('14','2008-02-17','MYSORE ROAD'),('15','2005-03-04','KANAKPURA ROAD');
INSERT INTO PARTICIPATED
VALUES('A01','KA052250',11,10000),('A02','KA053408',12,50000),('A03','KA095477',13,25000),('A04','KA031181',14,3000),('A05','KA041702',15,5000);

select accident_date,location
from accident;
select driver_id
from participated
where damage_amount>=25000;
select * from participated;
update participated
set damage_amount=25000
where report_num=12;
select * from participated;
insert into accident
values(16,'2003-02-02','HOSUR ROAD');
SELECT * FROM ACCIDENT;
SELECT reg_num,model,car_year
from car
order by car_year asc;
select count(c.reg_num)
from car c, participated p
where c.reg_num=p.reg_num;
select count(car.reg_num)
from participated,car
where car.model='LANCER' and car.reg_num=participated.reg_num;
select count(car.reg_num)
from participated,car
where car.car_year=2008 and car.reg_num=participated.reg_num;
select avg(damage_amount)
from participated;
delete from participated
where damage_amount<13600;
select * from participated;