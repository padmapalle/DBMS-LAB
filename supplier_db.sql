create database CS125_sdb;
use CS125_sdb;
create table SUPPLIERS
(
sid int primary key, 
sname varchar(20),
city varchar(20)
);
desc SUPPLIERS;
create table PARTS
(
pid int primary key,
pname varchar(20),
color varchar(10)
);
create table CATALOG(
sid int,
pid int,
foreign key(sid) references SUPPLIERS(sid),
foreign key(pid) references PARTS(pid), 
cost float(6),
primary key(sid, pid)
 );
desc catalog;

insert into suppliers values(10001, ' Acme Widget','Bangalore');
insert into suppliers values(10002, ' Johns','Kolkata');
insert into suppliers values(10003, ' Vimal','Mumbai');
insert into suppliers values(10004, ' Reliance','Delhi');


insert into PARTS values(20001,' Book','Red');
insert into PARTS values(20002,' pen','Red');
insert into PARTS values(20003,' pencil','green');
insert into PARTS values(20004,' mobile','green');
insert into PARTS values(20005,' charger','black');

insert into CATALOG values(10001, '20001','10');
insert into CATALOG values(10001, '20002','10');
insert into CATALOG values(10001, '20003','30');
insert into CATALOG values(10001, '20004','10');
insert into CATALOG values(10001, '20005','10');
insert into CATALOG values(10002, '20001','10');
insert into CATALOG values(10002, '20002','20');
insert into CATALOG values(10003, '20003','30');
insert into CATALOG values(10004, '20003','40');

select * from suppliers;
select * from PARTS;
select * from CATALOG;

SELECT DISTINCT P.pname
 FROM Parts P, Catalog C
 WHERE P.pid = C.pid;
 
 SELECT S.sname
 FROM Suppliers S
 WHERE NOT EXISTS ((SELECT P.pid FROM Parts P)
 MINUS (SELECT C.pid FROM Catalog C
 WHERE C.sid = S.sid)
 );
 
SELECT S.sname
FROM Suppliers S
WHERE NOT EXISTS (SELECT P.pid
FROM Parts P
WHERE P.color = ‘Red’
MINUS
( SELECT C.pid
FROM Catalog C, Parts P
WHERE C.sid = S.sid AND
C.pid = P.pid AND P.color = ‘Red’ )
);

select pname
from parts 
where pid in(select pid 
            from catalog
            where sid=(select sid
                       from suppliers 
                       where sname='Acme widget')minus,
                       (select pid 
                       from catalog 
                       where sid in(select sid
                                    from suppliers 
                                    where sname <>'Acme widget')
                                    );
                                    
SELECT DISTINCT C.sid FROM Catalog C
WHERE C.cost &gt; ( SELECT AVG (C1.cost)
FROM Catalog C1
WHERE C1.pid = C.pid );

SELECT P.pid, S.sname
FROM Parts P, Suppliers S, Catalog C
WHERE C.pid = P.pid
AND C.sid = S.sid
AND C.cost = (SELECT MAX (C1.cost)
FROM Catalog C1
WHERE C1.pid = P.pid);

