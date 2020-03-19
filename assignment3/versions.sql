use Reddit2

create table BannedUsers(
	UserId int not null foreign key references Users(UserId),
	BanId int not null
)

drop table BannedUsers

-- a. modify the type of a column;

go
create proc upVersion1 as
	alter table Awards alter column Cost money
go

go
create proc downVersion0 as
	alter table Awards alter column Cost int
go

-- b. add / remove a column;
go
create proc upVersion2 as
	alter table PremiumUsers drop column StartDate
go

go
create proc downVersion1 as
	alter table PremiumUsers add StartDate date
go

-- c. add / remove a DEFAULT constraint;
go
create proc upVersion3 as
	alter table Posts add constraint df_upvotes default 0 for Upvotes
go

go
create proc downVersion2 as
	alter table Posts drop constraint df_upvotes
go

-- d. add / remove a primary key;

go
create proc upVersion4 as
	alter table BannedUsers add constraint PK_banId primary key (BanId)
go

go
create proc downVersion3 as
	alter table BannedUsers drop constraint PK_banId
go

-- e. add / remove a candidate key;
go
create proc upVersion5 as
	alter table PremiumUsers add constraint uk_UserId unique (UserId)
go

go
create proc downVersion4 as
	alter table PremiumUsers drop constraint uk_UserId
go

-- f. add / remove a foreign key;

go 
create proc upVersion6 as
	alter table BannedUsers add constraint fk_UserId foreign key (UserId) references Users(UserId)
go 

create proc downVersion5 as 
	alter table BannedUsers drop constraint fk_UserId
go

-- g. create / remove a table.
go 
create proc upVersion7 as
	create table QuarantinedSubreddits(
		QuarantineId int primary key,
		SubredditId int foreign key references Subreddits(SubredditId)
	)
go

go
create proc downVersion6 as
	drop table QuarantinedSubreddits
go
--drop procedure downVersion0
--drop procedure downVersion1
--drop procedure downVersion2
--drop procedure downVersion3
--drop procedure downVersion4
--drop procedure downVersion5
--drop procedure downVersion6
--drop procedure downVersion7

--drop procedure upVersion0
--drop procedure upVersion1
--drop procedure upVersion2
--drop procedure upVersion3
--drop procedure upVersion4
--drop procedure upVersion5
--drop procedure upVersion6
--drop procedure upVersion7


exec upVersion1
exec downVersion0

exec upVersion2
exec downVersion1

exec upVersion3
exec downVersion2

exec upVersion4
exec downVersion3

exec upVersion5
exec downVersion4

exec upVersion6
exec downVersion5

exec upVersion7
exec downVersion6

create table Version(
	number int primary key
)

insert into Version values (0) 

CREATE PROCEDURE main
@version int
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @nextVersion varchar(50)
	DECLARE @currentVersion int
	SET @currentVersion = (SELECT number from Version)

	if @version < 0 or @version > 7
	BEGIN
		print('Invalid number')
		return 2
	END

	WHILE @currentVersion < @version
	BEGIN
		SET @currentVersion = @currentVersion + 1
		SET @nextVersion = 'upVersion' + CONVERT(varchar(3), @currentVersion)
		EXECUTE @nextVersion
	END

	WHILE @currentVersion > @version
	BEGIN
		SET @currentVersion = @currentVersion - 1
		SET @nextVersion = 'downVersion' + CONVERT(varchar(3), @currentVersion)
		EXECUTE @nextVersion
	END

	TRUNCATE TABLE Version
	insert into Version values(@version)
END

go
exec main 8

select * from Version
