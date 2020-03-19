insert into Awards(AwardId, Cost)
values (1, 100), (2, 500), (3, 1800)

insert into Subreddits(SubredditId, SubredditName, SubredditDescription, Members)
values(1, 'Reddit', 'a forum', 100000), (2, 'UBB', 'University from Cluj, Romania', 10000),
(3, 'Apple', 'A forum for apple enthusiats', 10000), (4, 'Samsung', 'Samsung forum', 100000),
(5, 'Physics', 'A place for physicians', 5000), (6, 'ProgrammingHumour', 'Here you can posts jokes about programming', 5000),
(7, 'AMA', 'Ask me anything', 4000), (8, 'food', 'For chefs and foodies', 3500), (9, 'awww', 'Here you can post cute things like puppies', 10000),
(10, 'movies', 'Place for movie watchers', 2500), (11, 'Programming', 'the StackOverflow of reddit', 6000)

insert into Pictures(PictureId, PictureLink)
values (1, 'imgur.com/45963'), (2, 'imgur.com/23246'), (3, 'imgur.com/51016'), (4, 'imgur.com/16500'), (5, 'imgur.com/86348'), (6, 'imgur.com/66247'), (7, 'imgur.com/65459'), (8, 'imgur.com/43241'), (9, 'imgur.com/72288'), (10, 'imgur.com/97322'), (11, 'imgur.com/13777'), (12, 'imgur.com/11746'), (13, 'imgur.com/40312'), (14, 'imgur.com/78951'), (15, 'imgur.com/47584'), (16, 'imgur.com/34963'), (17, 'imgur.com/22513'), (18, 'imgur.com/56612'), (19, 'imgur.com/99537')


SET DATEFORMAT dmy

insert into Users(UserId, UserName, UserMail, UserKarma, CakeDay)
values (1, 'LeonardM', 'leomihalcea@gmail.com', 751, Convert(varchar(30),'7/7/2011',102)),
(2, 'MariaP', 'pavalaumaria@gmail.com', 63741, Convert(varchar(30),'20/10/2019',102)),
(3, 'IstvanO', 'istvanolah@gmail.com', 300, Convert(varchar(30),'20/10/2017',102)),
(4, 'EricG', 'ericgabriel@gmail.com', 301, Convert(varchar(30),'23/04/2017',102)),
(5, 'MariaM', 'mariamihalcea@gmail.com', 351, Convert(varchar(30),'25/06/2019',102)),
(6, 'PetreI', 'petreispirescu@hotmail.com', 391, Convert(varchar(30),'28/07/2017',102)),
(7, 'DragosM', 'dragosmoldovanu@gmail.com', 999, Convert(varchar(30),'03/05/2018',102)),
(8, 'AlexM', 'alexminut@hotmail.com', 391, Convert(varchar(30),'14/02/2017',102)),
(9, 'AndreiB', 'andreib@hotmail.com', 321, Convert(varchar(30),'20/01/2017',102)),
(10, 'TaviM', 'tavimoldovanu@yahoo.com', 301, Convert(varchar(30),'23/04/2017',102)),
(11, 'EusebiuM', 'eusebiumihalcae@mail.com', 3911, Convert(varchar(30),'01/01/2019',102)),
(12, 'StefanM', 'stefanmihailescu@yahoo.com', 230, Convert(varchar(30),'31/05/2016',102))

insert into Posts(PostId, PictureId, Title, PostText, SubredditId, Upvotes, Downvotes, UserId)
values (1, 1, 'C# joke', 'insert random joke here', 6, 100, 2, 1),
(2, 2, 'AMA Programmer', 'ask me anything', 7, 1020, 23, 3),
(3, 3, 'Best Uni', 'best uni in romania', 2, 100, 1, 2),
(4, 4, 'New Samsung phone', 'here are the specifications', 4, 100, 2, 1),
(5, 5, 'New Iphone', 'a lot more expensive', 3, 100, 2, 1),
(6, 6, 'Great discovery', 'Nobel prize incoming', 5, 100, 2, 1),
(7, 7, 'really cute cat', 'cutest cat ever', 9, 100, 2, 1),
(8, 8, 'Beef Wellington', 'here is the recipe: ', 8, 100, 2, 1),
(9, 9, 'Se7en', 'great movie', 10, 100, 2, 1),
(10, 10, 'Python help', 'Need help', 11, 100, 2, 1),
(11, 11, 'ProgrammingHumour', 'An SQl Querry walks into a bar..', 6, 100, 2, 1),
(12, 12, 'Really cute doggo', 'best doggo out there', 9, 100, 2, 1),
(13, 13, 'Java joke', 'one eternity later', 6, 100, 2, 1)

insert into Admins(AdminId, UserId, AdminTitle)
values(1, 1, 'Owner'), (2, 2, 'Second owner'), (3, 3, 'First admin'),
(4, 4, 'Second admin'), (5, 5, 'General Admin')

insert into PostsAwards(PostId, AwardId)
values (1, 1), (2, 1), (3, 1), (7, 1),
(9, 2), (13, 2), (12, 2), (1, 2),
(1, 3), (8, 3), (5, 3)

insert into PremiumUsers(PUserId, UserId, LastPayment, StartDate, PaymentToken)
values (1, 1,  Convert(varchar(30),'7/7/2011',102),  Convert(varchar(30),'7/7/2011',102), '1'),
(2, 2,  Convert(varchar(30),'1/6/2012',102),  Convert(varchar(30),'17/1/2012',102), '2'),
(3, 3,  Convert(varchar(30),'6/2/2013',102),  Convert(varchar(30),'27/4/2013',102), '3'),
(4, 4,  Convert(varchar(30),'12/4/2014',102),  Convert(varchar(30),'12/5/2014',102), '4'),
(5, 5,  Convert(varchar(30),'21/1/2015',102),  Convert(varchar(30),'12/2/2015',102), '5')

insert into Ads(AdId, PostId, StartDate, EndDate, Price)
values (1, 3, Convert(varchar(30),'12/2/2015',102), Convert(varchar(30),'12/2/2017',102), 100),
(2, 4, Convert(varchar(30),'15/3/2015',102), Convert(varchar(30),'12/3/2017',102), 150),
(3, 9, Convert(varchar(30),'13/4/2015',102), Convert(varchar(30),'12/3/2017',102), 150),
(4, 5, Convert(varchar(30),'19/1/2015',102), Convert(varchar(30),'12/3/2017',102), 150)

insert into Comments(CommentId, CommentText, PostId, Upvotes, Downvotes)
values (1, 'Really funny!!!', 1, 200, 5),
(2, 'Yes it is', 3, 210, 5),
(3, 'Nice Iphone', 5, 220, 5),
(4, 'Nice Samsung', 4, 300, 5),
(5, 'Really cool discovery!', 6, 250, 5),
(6, 'Great movie indeed!', 9, 290, 5),
(7, 'Just use a global variable..', 10, 100, 5),
(8, 'Cutest doggo ever', 12, 2200, 5),
(9, 'Delicious but really complex to cook', 8, 20, 5)

