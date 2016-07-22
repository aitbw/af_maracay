# You need to run 'whenever' on your shell to convert these events
# to CRON syntax. If you want to run these jobs locally, you'll need to
# type 'whenever --update-crontab' on your console. Be aware that the
# SQL syntax used here is PG-specific. If you're using MySQL/MariaDB,
# replace 'CURRENT_DATE' with 'CURDATE()'

# If you're deploying to Heroku, please refer to Heroku Scheduler

# This CRON job was created to update the signups' statuses
# if they've expired, so the Alliance Francaise clerks know which
# students need to renew their signups.
every 1.day, at: '1:00 AM' do
  query = "UPDATE signups SET signup_status = 'Inscripción expirada' WHERE CURRENT_DATE >= signups.expiration_date"
  runner "ActiveRecord::Base.connection.execute(#{query})"
end

# This CRON job was created to update the fees' statuses
# if they've expired, so the Alliance Francaise clerks know which
# students need to renew their fees.
every 1.day, at: '2:00 AM' do
  query = "UPDATE fees SET fee_status = 'Cuota expirada' WHERE CURRENT_DATE >= fees.expiration_date"
  runner "ActiveRecord::Base.connection.execute(#{query})"
end
