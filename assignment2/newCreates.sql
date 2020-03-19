create table Categories(
	CatId int primary key,
	CategoryName varchar(255)
)

create table SubredditCategorie(
	CatId int,
	SubredditId int,
	constraint SubredditCateogie primary key (CatId, SubredditId),
	constraint fk_CatId foreign key (CatId) references Categories(CatId),
	constraint fk_SubredditId foreign key (SubredditId) references Subreddits(SubredditId)
)