
JOB=bin/ruby/jess_cancels_last_3_months.rb
RESPONSE=$(ruby $JOB)

# Log as a failed job so it can be ran again tomorrow
if [ $RESPONSE ] && [ $RESPONSE == "failed" ]; then
  cp -f $0 failed/
fi
