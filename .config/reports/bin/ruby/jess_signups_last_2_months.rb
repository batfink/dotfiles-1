######################################################################################
#
# Send a Signup report to Jess
#
# This report covers some basic sign up information with important dates, plan types,
# and identifying user information
#
######################################################################################

begin

  require './lib/mailer.rb'
  require './lib/database.rb'

  # Reports
  require './reports/signups_last_n_months'

  email = "jessica@shortstacklab.com"
  subject = "Sign Ups (free and paid) - Last 3 Months"
  body = """
    Hi Jess,

    Here is your sign up report. It displays information regarding sign ups,
    both free and paid, over the last 2 months.

    - Cody
    """

  Mailer.deliver(email, subject, body, nil, SignUpsLastNMonthsReport.new.run(2))

rescue
  puts "failed"
end
