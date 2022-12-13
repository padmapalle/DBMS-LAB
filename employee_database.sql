create database 1bm21cs125_emp_id;
use 1bm21cs125_emp_id;
create table dept(
d_no int,
d_name varchar (10),
d_loc varchar (30),
primary key(d_no)
);
create table project(
p_no int,
p_loc varchar(20),
p_name varchar(15),
PRIMARY KEY(p_no)
);
create table employee(
emp_no int,
emp_name varchar(10),
mgr_no int,
hiredate date,
sal real,
d_no int,
primary key(emp_no),
foreign key(d_no) references dept(d_no)
on update cascade on delete cascade
);

create table incentives(
emp_no int,
incentive_date date,
incentive_amt real,
primary key(incentive_date),

foreign key(emp_no) references employee(emp_no)
on update cascade on delete cascade
);
create table assigned(
emp_no int,
p_no int,
job_role varchar(10),

foreign key(emp_no) references employee(emp_no)
on update cascade on delete cascade,
foreign key(p_no) references project(p_no)
on update cascade on delete cascade
);
select *from employee;
select *from assigned;
select *from incentives;
select *from project;
select *from dept;
insert into dept values(100,'IT','jaipur');
insert into dept values(200,'Marketing','gangtok');
insert into dept values(300,'HR','srinagar');
insert into dept values(400,'finance','kolkata');
insert into dept values(500,'logistics','bangalore');
insert into dept values(600,'accounts','ajmer');
insert into dept values(700,'design','hydrebad');
insert into project values(10,'jaipur','risco');
insert into project values(20,'gangtok','cisco');
insert into project values(30,'srinagar','nisnco');
insert into project values(40,'kolkata','mismco');
insert into project values(50,'bangalore','lislco');
insert into project values(60,'ajmer','sin');

insert into employee values(01,'ram',11,'2011-01-11',10000,500);
insert into employee values(02,'sita',22,'2012-02-12',15000,100);
insert into employee values(03,'ryan',33,'2013-03-23',20000,300);
insert into employee values(04,'arya',44,'2014-04-04',25000,200);
insert into employee values(05,'suzu',55,'2015-05-25',30000,500);
insert into employee values(06,'chahal',66,'2016-06-26',35000,500);
insert into employee values(07,'chaya',77,'2017-07-27',40000,400);
insert into employee values(08,'naira',88,'2018-08-28',45000,100);
insert into employee values(09,'arav',99,'2019-09-29',50000,200);
insert into employee values(10,'rahul',111,'2020-10-11',55000,300);

insert into incentives values(01,'2021-05-11',1000);
insert into incentives values(03,'2022-04-20',1500);
insert into incentives values(05,'2021-09-10',2000);
insert into incentives values(07,'2022-06-21',2500);
insert into incentives values(09,'2021-04-17',3000);
insert into incentives values(10,'2022-10-19',3500);

insert into assigned values(01,20,'architect');
insert into assigned values(02,10,'peon');
insert into assigned values(03,30,'supervisor');
insert into assigned values(04,60,'assistant');
insert into assigned values(05,50,'mason');
insert into assigned values(06,50,'manager');
insert into assigned values(07,40,'medic');
insert into assigned values(08,60,'mechanic');
insert into assigned values(09,30,'engineer');
insert into assigned values(10,30,'maid');
select *from employee;
select *from assigned;
select *from incentives;

select *from project;
select *from dept;
select emp_no from assigned,project where assigned.p_no=project.p_no and project.p_loc
in('mysore','bangalore','hydrebad');
select emp_no from employee where emp_no not in(select incentives.emp_no
from employee cross join incentives
on employee.emp_no=incentives.emp_no);
select e.emp_name,e.emp_no,d.d_name,a.job_role,d.d_loc,p.p_loc
from employee e, dept d, assigned a, project p
where d.d_no=e.d_no
and e.emp_no=a.emp_no
and a.p_no=p.p_no
and p.p_loc=d.d_loc;
select e.emp_name,d.d_name,a.job_role
from employee e,dept d,assigned a
where e.emp_no in (select emp_no
from incentives
where incentive_amt=
(select max(incentive_amt)
from incentives
where incentive_date between'2021-01-01' and '2021-12-31'))
and d.d_no=e.d_no and a.emp_no=e.emp_no;

select E.ename,(count(*)) 
from employee E 
where E.emp_no in (select P.mgr_no 
                   from employee P 
                   where P.mgr_no=E.emp_no 
                   group by E.ename); 

select E.ename 
from employee E 
where E.emp_no in (select P.mgr_no 
                   from employee P
                   where sal>(select avg(sal)
                   from employee G 
                   where G.mgr_no=E.emp_no));

select E.ename
from employee E
where E.emp_no in (select P.mgr_no
                   from employee P
                   where 1=(select count(sal)
                   from employee G where G.sal);

select m.ename,count(*) 
from employee e,employee m 
where e.mgr_no=m.emp_no 
group by m.ename 
having count(*)=(select max(mycount) 
                 from employee
                 group by mgr_no) a);

select E.ename
from employee e,employee m 
where e.mgr_no=m.emp_no and
      m.dept_no=e.dept_no;

