# This needs to run at 5:30AM everyday.

# Creates and begins populating the status.txt file, which will be the body of the email.
echo "touch /home/jline/ref.txt" | at 05:40
echo "echo \"[5:30AM]: sh one_script_to_rule_them_all.sh \" >> /home/jline/ref.txt" |at 05:41
# Creates a queue of at jobs from 6AM-6AM.
# Adds  line to status.txt, confirming that jobs for the next day are in the queue.
at 05:45 < make_night_schedule.sh 

# At 6:05AM, check to see if there are 24*2*4 files in ./data/*/*.
# If there are, source do_rsync.sh then source clear_data.sh. Send email to Aman.
# If there are files missing, source do_rsync, but don't clear data. Send email to Aman, Jack, Nichole.
# Emails are sent at 6:20AM

echo "echo \"[6:00AM]: A new day begins \" >> /home/jline/ref.txt" |at 05:41
echo "echo \"[6:02AM]: Checking for missing data files from the last 24 hours.\" >> /home/jline/ref.txt" | at 06:02
at 06:03 < check_missing.sh
at 06:04 < do_rsync_clear.sh

# Clean up and get ready for next day
echo "rm ref.txt" | at 06:25
