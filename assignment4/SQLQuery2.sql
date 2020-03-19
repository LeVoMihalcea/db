
--one primary key
create table Owners(
	OwnerId int primary key
)

--one primary and one foreign
--QuarantinedSubreddits

--multicolumn primary key
--PostAwards

insert into Owners
values (1), (2), (3), (4), (5), (6)

go
create view ViewOwners
as
	select * from Owners
go

--a view with a SELECT statement operating on at least 2 tables;
go
create view UsersAndPosts
as
	select * from PremiumUsers pu 
	where exists(select UserId from Posts p where pu.UserId = p.UserId)
go

--a view with a SELECT statement that has a GROUP BY clause and operates on at least 2 tables.

go
create view ViewAvgUpvotes
as
	select s.SubredditName, avg(p.Upvotes) as medie
	from Subreddits s inner join Posts p
	on s.SubredditId = p.SubredditId
	group by s.SubredditName
go

delete from Views
insert into Views values ('ViewOwners'), ('UsersAndPosts'), ('ViewAvgUpvotes')

delete from Tables
insert into Tables values ('Owners'), ('QuarantinedSubreddits'), ('PostAwards')

delete from Tests
insert into Tests values('select_view'),
	('insert_owner'), ('delete_owner'),
	('insert_UserAndPost'), ('delete_UserAndPost'),
	('insert_PostAward'), ('delete_PostAward')

select * from Views
select * from Tables
select * from Tests

delete from TestViews
insert into TestViews values (1, 1), (1, 2), (1, 3)

delete from TestTables

insert into TestTables(TestId, TableId, NoOfRows, Position)
values (3, 1, 3000, 1), (5, 2, 3000, 2), (7, 3, 3000, 3)

select * from TestTables

--------------------------------------------------------------

delete from TestRunViews
delete from TestRuns
delete from TestRunTables

--------------------------------------------------------------

select * from Owners
go
create or alter proc deleteOwner
as
	delete from Owners where OwnerId >= 1
go

GO
CREATE OR ALTER PROC insertOwner
AS
	DECLARE @Index INT = 1
	 DECLARE @NoOfRows INT
	 SELECT @NoOfRows = NoOfRows FROM TestTables WHERE TestId = 3
	 
	WHILE @index <= @NoOfRows
    BEGIN
      INSERT INTO Owners VALUES (@index + 1)
      SET @index = @Index + 1
    END
GO

------------------------------------------------------------------

GO
CREATE OR ALTER PROC deleteQuarantinedSubreddit
AS
  DELETE FROM QuarantinedSubreddits
GO

GO
CREATE OR ALTER PROC insertQuarantinedSubbredit
AS
	DECLARE @Index INT = 0
	 DECLARE @NoOfRows INT
	 SELECT @NoOfRows = NoOfRows FROM TestTables WHERE TestId = 5
	 
	WHILE @index < @NoOfRows
    BEGIN
      INSERT INTO QuarantinedSubreddits VALUES (@index + 1, 1)
      SET @index = @Index + 1
    END
GO

-------------------------------------------------

GO
CREATE OR ALTER PROC deletePostsAwards
AS
  DELETE FROM PostsAwards 
GO

GO
CREATE OR ALTER PROC insertPostsAwards
AS
	DECLARE @Index INT = 0
	DECLARE @NoOfRows INT
	SELECT @NoOfRows = NoOfRows FROM TestTables WHERE TestId = 7
	 
	WHILE @index < @NoOfRows
    BEGIN
      INSERT INTO PostAwards VALUES (@index + 1, @index + 1, 3)
      SET @index = @Index + 1
    END
GO

-------------------------------------------
select * from Views

create or alter PROC TestRunView
as
  begin
    DECLARE @startTime1 DATETIME;
    DECLARE @endTime1 DATETIME;
    DECLARE @startTime2 DATETIME;
    DECLARE @endTime2 DATETIME;
    DECLARE @startTime3 DATETIME;
    DECLARE @endTime3 DATETIME;

    SET @startTime1 = GETDATE();
    EXEC ('select * from ViewOwners');
    PRINT 'select * from ViewOwners';
    SET @endTime1 = GETDATE();

    INSERT INTO TestRuns VALUES ('test_view', @startTime1, @endTime1)
    INSERT INTO TestRunViews(TestRunID, ViewID, StartAt, EndAt) values (@@IDENTITY, 1, @startTime1, @endTime1);

    SET @startTime2 = GETDATE();
    EXEC ('select * from UsersAndPosts');
    PRINT 'select * from UsersAndPosts';
    SET @endTime2 = GETDATE();
    INSERT INTO TestRuns VALUES ('test_view2', @startTime2, @endTime2)
    INSERT INTO TestRunViews(TestRunID, ViewID, StartAt, EndAt) values (@@identity, 2, @startTime2, @endTime2);

    SET @startTime3 = GETDATE();
    EXEC ('select * from ViewAvgUpvotes');
    PRINT 'select * from ViewAvgUpvotes';
    SET @endTime3 = GETDATE();
    INSERT INTO TestRuns VALUES ('test_view3', @startTime3, @endTime3)
    INSERT INTO TestRunViews(TestRunID, ViewID, StartAt, EndAt) values (@@identity, 3, @startTime3, @endTime3);
  end
GO
exec TestRunView

delete from TestRuns
select * from TestRuns

GO
--drop proc TestRunInsertRemove
CREATE OR ALTER PROC TestRunInsertRemove
  AS
    begin
      DECLARE @startTime1 DATETIME;
      DECLARE @endTime1 DATETIME;

      DECLARE @startTime2 DATETIME;
      DECLARE @endTime2 DATETIME;

      DECLARE @startTime3 DATETIME;
      DECLARE @endTime3 DATETIME;

      DECLARE @startTime4 DATETIME;
      DECLARE @endTime4 DATETIME;

	  DECLARE @startTime5 DATETIME;
      DECLARE @endTime5 DATETIME;

	  DECLARE @startTime6 DATETIME;
      DECLARE @endTime6 DATETIME;

      SET @startTime1 = GETDATE()
      EXEC insertOwner
      PRINT ('exec insertOwner')
      SET @endTime1 = GETDATE()
      INSERT INTO TestRuns VALUES ('test_insert_owner', @startTime1, @endTime1)
      INSERT INTO TestRunTables VALUES (@@IDENTITY, 1, @startTime1, @endTime1)

      SET @startTime2 = GETDATE()
      EXEC deleteOwner
      PRINT ('exec deleteOwner')
      SET @endTime2 = GETDATE()
      INSERT INTO TestRuns VALUES ('test_delete_owner', @startTime2, @endTime2)
      INSERT INTO TestRunTables VALUES (@@IDENTITY, 1, @startTime1, @endTime1)

      SET @startTime3 = GETDATE()
      exec insertQuarantinedSubbredit
      print ('exec insertQuarantinedSubreddit')
      SET @endTime3 = GETDATE()
      INSERT INTO TestRuns values ('test_insert_QuarantinedSubreddit', @startTime3, @endTime3)
      INSERT INTO TestRunTables VALUES (@@IDENTITY, 2, @startTime3, @endTime3)

      SET @startTime4 = GETDATE()
      exec deleteQuarantinedSubreddit
      print ('exec deleteQuarantinedSubreddit')
      SET @endTime4 = GETDATE()
      INSERT INTO TestRuns values ('test_delete_QuarantinedSubreddit', @startTime4, @endTime4)
      INSERT INTO TestRunTables VALUES (@@IDENTITY, 2, @startTime4, @endTime4)
	  
      SET @startTime5 = GETDATE()
      exec insertPostsAwards
      print ('exec insertPostsAwards')
      SET @endTime5 = GETDATE()
      INSERT INTO TestRuns values ('test_insert_PostsAwards', @startTime5, @endTime5)
      INSERT INTO TestRunTables VALUES (@@IDENTITY, 3, @startTime5, @endTime5)

      SET @startTime6 = GETDATE()
      exec deletePostsAwards
      print ('exec deletePostsAwards')
      SET @endTime6 = GETDATE()
      INSERT INTO TestRuns values ('test_delete_PostsAwards', @startTime6, @endTime6)
      INSERT INTO TestRunTables VALUES (@@IDENTITY, 3, @startTime6, @endTime6)

    end
GO

delete from TestRuns

exec TestRunView
exec TestRunInsertRemove

select * from TestRuns
select * from TestRunTables
select * from TestRunViews
