
#User.create(email: 'test@example.com', encrypted_password: '#$taawktljasktlw4aaglj')

user = User.new
#user.email = 'test@example.com'
#user.encrypted_password = '#$taawktljasktlw4aaglj'
#user.email = 'qqq@qqq.com'
user.email = 'shiegin@gmail.com'
#user.encrypted_password = 'qqqqqqqq'
user.password = 'qqqqqqqq'
user.is_admin = true
user.save!


