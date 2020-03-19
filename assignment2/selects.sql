use Reddit2
go

--a. 2 queries with the union operation; use UNION [ALL] and OR;

--select users using hotmail or mail
select * from Users
where UserMail like '%@hotmail.com'
union
select * from Users
where UserMail like '%@mail.com'

--select all users starting or ending with M
select * from Users
where UserName like 'M%' or UserName like '%M'

--b. 2 queries with the intersection operation; use INTERSECT and IN;

--select all users that registered before 2018 and are using hotmail
select * from Users
where CakeDay < '2018-1-1'
intersect
select * from Users
where UserMail like '%@hotmail.com'

--select all users using hotmail and having neutral karma
select * from Users
where UserMail like '%@hotmail.com' and UserKarma in ( 0 )

--c. 2 queries with the difference operation; use EXCEPT and NOT IN;

--select all users using hotmail and not having negative karma
select * from Users
where UserMail like '%@hotmail.com'
except
select * from Users
where UserKarma < 0

--select all posts from subreddit from ProgrammingHumor (id6) not posted by LeonardM(id1) or MariaP(id2)
select * from Posts
where SubredditId = 6 and UserId not in (1, 2)

--d. 4 queries with INNER JOIN, LEFT JOIN, RIGHT JOIN, and FULL JOIN; one query will join at least 3 tables, while another one will join at least two many-to-many relationships;

--select all posts from a subreddit along with the subreddit details
select * from Posts
inner join Subreddits
on Posts.SubredditId = Subreddits.SubredditId

--select all users along with their posts
select * from Users
left join Posts
on Users.UserId = Posts.UserId


--select all users along with their posts
select * from Users
right join Posts
on Users.UserId = Posts.UserId

--select all posts made by admins
select * from Posts p
left join Users u
on p.UserId = u.UserId
left join Admins a
on a.UserId = p.UserId

--select all posts and all users
select * from Posts p
full join Users u
on u.UserId = p.UserId

--i have no idea what this is supposed to do but okay
select * from Subreddits s
inner join Posts p
on p.SubredditId = p.SubredditId
inner join Users u
on p.UserId = u.UserId

--select all subreddits that have an least one post with an award
select Subreddits.SubredditId, Subreddits.SubredditName, Posts.Title, PostsAwards.AwardId
from(
	(
		(
				SubredditCategorie full join Subreddits on SubredditCategorie.SubredditId = Subreddits.SubredditId
		) full join Posts on Subreddits.SubredditId = Posts.SubredditId
	) full join PostsAwards on Posts.PostId= PostsAwards.PostId
)

--e. 2 queries using the IN operator to introduce a subquery in the WHERE clause; in at least one query, the subquery should include a subquery in its own WHERE clause;

--find everyone that posted at least once
select * from Users
where UserId in (select UserId from Posts)

--find every premium user that posted at least once
select * from PremiumUsers ps
where ps.UserId in (
		select UserId from Users u
		where u.UserId in(
			select p.UserId from Posts p
		)
)

--f. 2 queries using the EXISTS operator to introduce a subquery in the WHERE clause;

--selects all premium users with a karma over 5500
select Users.UserId from Users
where exists (
	select PremiumUsers.UserId from PremiumUsers where Users.UserId = PremiumUsers.UserId and Users.UserKarma > 5500
)

--selects all admins with a karma over 5500
select Users.UserId from Users
where exists(
	select Admins.UserId from Admins where Admins.UserId = Users.UserId and Users.UserKarma > 5500
)

--find everyone that posted at least once
select * from Users u
where exists(select UserId from Posts p where u.UserId = p.UserId)

--find every premium user that posted at least once
select * from PremiumUsers pu
where exists(select UserId from Posts p where pu.UserId = p.UserId)

--g. 2 queries with a subquery in the FROM clause

--find everyone that posted at least once
select * from (
	select * from Users
	where UserId in (select UserId from Posts)
) a

--find every premium user that posted at least once
select * from (
	select * from PremiumUsers
	where UserId in (select UserId from Posts)
) PU

--h. 4 queries with the GROUP BY clause, 3 of which also contain the HAVING clause; 2 of the latter will also have a subquery in the HAVING clause; use the aggregation operators: COUNT, SUM, AVG, MIN, MAX;

--average of upvotes for each subreddit
select s.SubredditName, avg(p.Upvotes)
from Subreddits s inner join Posts p
on s.SubredditId = p.SubredditId
group by s.SubredditName

--count all the posts in all subreddits where there are at least n=2 posts
select count(p.SubredditId), s.SubredditName 
from Posts p inner join Subreddits s on p.SubredditId = s.SubredditId
group by s.SubredditName
having count(p.SubredditId) > 1

--select top 5 subreddit ids that have at least one post, sorted descending by number of posts
select top(5) Count(Posts.PostId), Posts.SubredditId
from Posts
group by Posts.SubredditId
having Posts.SubredditId in (
	select Posts.SubredditId from Posts
)
order by Count(Posts.PostId) desc

--select top 5 pictures that appear at least once in posts, sorted descending by number of apparitions
select top(5) Count(Pictures.PictureId), Pictures.PictureLink
from Pictures
group by PictureLink
having PictureId in (
	select Posts.PictureId from Posts
)
order by Count(Pictures.PictureId) desc

--i. 4 queries using ANY and ALL to introduce a subquery in the WHERE clause; 2 of them should be rewritten with aggregation operators, while the other 2 should also be expressed with [NOT] IN.

--select all the posters with the highest karma
select Users.UserId, Users.UserName
from Users
where Users.UserKarma >= all (select Users.UserKarma from Users)

--select all the posters with the highest karma -rewritten
select Users.UserId, Users.UserName
from Users
where Users.UserKarma = any (select max(Users.UserKarma) from Users)

--select all posts with the lowest number of downvotes
select * 
from Posts p
where p.Downvotes <= all ( select Posts.Downvotes from Posts )

--select all posts with the lowest number of downvotes
select *
from Posts p
where p.Downvotes = any ( select min(Posts.Downvotes) from Posts)



--extra stuff

--print the karma generation of each post
select Posts.Upvotes - Posts.Downvotes, Posts.Title
from Posts

--print the karma generation of each comment
select Comments.Upvotes - Comments.Downvotes, Comments.CommentId
from Comments

--print the runtime of each ad
select datediff(DAY ,Ads.EndDate, Ads.StartDate), Ads.AdId
from Ads