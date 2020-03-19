use lab5

drop table Ta
drop table Tb
drop table Tc

create table Ta(
	aid int primary key,
	a2 int unique,
	somethingNice varchar(100),
)

create table Tb(
	bid int primary key,
	b2 int,
	somethingEvenNicer varchar(200),
)

create table Tc(
	cid int primary key,
	aid int foreign key references Ta(aid),
	bid int foreign key references Tb(bid)	
)

insert into Ta (aid, a2, somethingNice)
values (1, 1, 'first'), (2, 2, 'second'), (3, 3, 'third'), (4, 4, 'fourth'), (5, 5, 'fifth'), (6, 6, 'sixth'), (7, 7, 'seventh')

insert into Tb(bid, b2, somethingEvenNicer)
values (1, 1, 'first'), (2, 2, 'second'), (3, 3, 'third'), (4, 4, 'fourth'), (5, 5, 'fifth')

insert into Tc(cid, aid, bid)
values (1, 1, 1), (2, 2, 2), (3, 3, 3), (4, 4, 4), (5, 5, 5)

select * from Ta order by aid
select * from Tb order by bid
select * from Tc order by cid

IF EXISTS (SELECT name FROM sys.indexes WHERE name = N'N_Tb_b2')
 DROP INDEX N_Tb_b2 ON Tb;
GO
-- Create a nonclustered index called N_Tb_b2 on the Tb table using the b2 column.
CREATE NONCLUSTERED INDEX N_Tb_b2 ON Tb(b2); 
GO

-- clustered index scan
SELECT * FROM Ta ORDER BY aid

-- clustered index seek
SELECT a.aid FROM Ta a
INNER JOIN Tb b ON a.aid = b.bid

-- non clustered index scan && key lookup
SELECT * FROM Ta ORDER BY a2

-- non clustered index seek
SELECT *
FROM Ta a
WHERE a2 = 5

-- b
SELECT *
FROM Tb b
WHERE b2 = 2

-- c
drop view testView

GO
CREATE VIEW testView
AS
	SELECT a.somethingNice
	FROM Ta a 
	INNER JOIN Tb b ON a.a2 = b.b2
	INNER JOIN Tc c on c.aid = a.aid
GO

-- uses N_Tb_2 
SELECT * FROM testView

select * from sys.indexes