
JOB=bin/ruby/jess_signups_last_2_months.rb
RESPONSE=$(ruby $JOB)

# Log as a failed job so it can be ran again tomorrow
if [ $RESPONSE ] && [ $RESPONSE == "failed" ]; then
  cp -f $0 failed/
fi
