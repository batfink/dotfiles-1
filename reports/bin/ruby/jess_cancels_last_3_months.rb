######################################################################################
#
# Send a Cancelation report to Jess
#
# This report covers some basic cancelation information with important dates and user
# identifying information.
#
######################################################################################

begin

  require './lib/mailer.rb'
  require './lib/database.rb'

  # Reports
  require './reports/cancels_last_n_months'

  email = "jessica@shortstacklab.com"
  subject = "Cancelations - Last 3 Months"
  body = """
    Hi Jess,

    Here is your cancelation report. It displays information regarding cancelations over
    the last 3 months.

    - Cody
    """

  Mailer.deliver(email, subject, body, nil, CancelsLastNMonthsReport.new.run(3))

rescue
  puts "failed"
end
