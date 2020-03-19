--create database Reddit2
--use Reddit2

--1
create table Pictures(
	PictureId int primary key,
	PictureLink varchar(255)
)

--2
create table Users(
	UserId int primary key,
	UserName varchar(255),
	UserMail varchar(255),
	UserKarma int,
	CakeDay date,
	ProfilePicId int foreign key references Pictures(PictureId)
)

--3
create table Admins(
	AdminId int primary key,
	UserId int foreign key references Users(UserId),
	AdminTitle varchar(255),
)

--4
create table Subreddits(
	SubredditId int primary key,
	SubredditName varchar(255),
	SubredditDescription varchar(255),
	Members int
)

--5
create table Posts(
	PostId int primary key,
	UserId int foreign key references Users(UserId),
	PictureId int foreign key references Pictures(PictureId),
	SubredditId int foreign key references Subreddits(SubredditId),
	Title varchar(255),
	PostText varchar(255),
	Upvotes int,
	Downvotes int
)

--6
create table Awards(
	AwardId int primary key,
	Cost int
)

--7
create table PostsAwards(
	PostId int,
	AwardId int,
	constraint PostAwardPK primary key(PostId, AwardId),
	constraint FK_PostId foreign key (PostId) references Posts(PostId),
	constraint FK_AwardId foreign key (AwardId) references Awards(AwardId)
)

--8
create table PremiumUsers(
	PUserId int primary key,
	UserId int foreign key references Users(UserId),
	LastPayment date,
	StartDate date,
	PaymentToken varchar(255)
)

--9
create table Ads(
	AdId int primary key,
	PostId int foreign key references Posts(PostId),
	Price int,
	StartDate date,
	EndDate date,
)

--10
create table Comment(
	CommentId int primary key,
	PostId int foreign key references Posts(PostId),
	CommentText varchar(255),
	UserId int foreign key references Users(UserID),
	Upvotes int,
	Downvotes int
)
