--delete an user
delete from Users
where UserName = 'PetreI'

--delete an user that hasn't paid for a while
delete from PremiumUsers
where LastPayment < '2012-1-1'



