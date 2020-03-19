
--change someone's email
update Users
set UserMail = 'istvanolah@hotmail.com'
where UserId = 3

--change a post picture
update Posts
set PictureId = 14
where PostId = 4 or PostId = 5

--change the price for an award
update Awards
set Cost = 1500
where AwardId = 3

--update all karma from null to 0
update Users
set UserKarma = 0
where UserKarma is null

--reset downvotes counter for posts that have less than 20 downvotes
update Posts
set Downvotes = 0
where Downvotes between 0 and 20

--give 5000 karma to each admin
update Users
set UserKarma = UserKarma + 5000
where UserId in (select UserId from Admins)

--take 500 from users using hotmail, bleah
update Users
set UserKarma = UserKarma - 500
where UserMail like '%@hotmail.com'