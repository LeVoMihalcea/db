create database exam

use exam

create table Currencies(
	id int primary key identity,
	name varchar(255),
	country varchar(255)
)

create table Banknotes(
	id int primary key identity,
	value int,
	currencyId int foreign key references Currencies(id),
	transactionId int foreign key references Transactions(id)	
)

create table Users(
	id int primary key identity,
	username varchar(255) unique
)

create table Products(
	id int primary key identity,
	name varchar(255),
	price int,
	currencyId int foreign key references Currencies(id)
)

create table Transactions(
	id int primary key identity,
	userId int foreign key references Users(id),
	productId int foreign key references Products(id),
	dat varchar(255)
)

delete from Transactions
delete from Banknotes
delete from Products
delete from Currencies
delete from Users

DBCC CHECKIDENT ('Currencies', RESEED, 0);
GO
DBCC CHECKIDENT ('Products', RESEED, 0);
GO
DBCC CHECKIDENT ('Banknotes', RESEED, 0);
GO
DBCC CHECKIDENT ('Transactions', RESEED, 0);
GO
DBCC CHECKIDENT ('Users', RESEED, 0);
GO

select * from Currencies
select * from Products
select * from Transactions
select * from Users
select * from Banknotes

insert into Users(username)
values
('user1'),
('user2'),
('user3'),
('user4'),
('user5')

insert into Currencies(name, country)
values
('ron', 'romania'),
('dinars', 'serbia'),
('dollars', 'usa'),
('pounds', 'uk')

insert into Products(name, price, currencyId)
values
('product1', 100, 1),
('product2', 120, 2),
('product3', 140, 3),
('product4', 150, 4),
('product5', 10, 1),
('product6', 200, 2),
('product7', 120, 3),
('product8', 80, 4),
('product9', 500, 4)

insert into Transactions(userId, productId, dat)
values
(1, 1, '1-1-2020'),
(1, 2, '1-1-2020'),
(1, 3, '1-1-2020'),
(2, 4, '1-1-2020'),
(2, 5, '1-1-2020'),
(2, 6, '1-1-2020'),
(3, 7, '1-1-2020'),
(3, 8, '1-1-2020'),
(3, 9, '1-1-2020')

insert into Banknotes(value, currencyId, transactionId)
values
(10, 1, 1),
(50, 1, 2),
(100, 1, 3),
(10, 2, 4),
(50, 2, 5),
(100, 2, 6),
(100, 2, 6),
(10, 3, null),
(50, 3, null),
(100, 3, null),
(10, 4, null),
(50, 4, null),
(100, 4, null)

create or alter procedure deleteUser @userid int
as
	update Banknotes
	set transactionId = null
	where Banknotes.transactionId in
		(select Transactions.id from Transactions
			where Transactions.userId = @userid)

	delete from Transactions
	where Transactions.userId = @userid
	
	delete from Users
	where Users.id = @userid
go

select * from Banknotes
select * from Transactions
select * from Users
exec deleteUser 2

create or alter view productsAssociatedWithCurrency
as
	select Currencies.name, count(Products.currencyId) as numberOfProducts from Currencies
	left join Products on Products.currencyId = Currencies.id
	group by Currencies.name
go

select * from productsAssociatedWithCurrency
order by numberOfProducts desc

create or alter function mostActiveUsers()
returns table
as
	return
		select top 3 Users.username, count(Transactions.userId) as numberOfTransactions from Users
		left join Transactions on Transactions.userId = Users.id
		group by Users.username
go


(select * from mostActiveUsers()) 