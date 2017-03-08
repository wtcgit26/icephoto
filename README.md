# icephoto

usage: icephoto.sh [--verbose] [--description \"archive description\"] [--account-id aws_account-id] --vault-name aws_vault-name --size part_size[k|m] --filename input_file<br />
aws_account-id if blank will be '-'<br />
part_size == can be 1000k for 1000 kilobytes or 250m for 250 megabytes (e.g. split byte command)<br />
input_file == archive file to be split and uploaded (typically a .gz file)<br />
<br />
Created: 5 March 2017<br />
<br />
Purpose: <br />
Split gz file into chunks<br />
Send Photo Archives up to Amazon Glacier<br />
Returns verbose output to stdout<br />
<br />
Actions:<br />
-- Cleanup the output so that it json compliant<br />
-- Error handling on the AWS Side<br />
-- Account Setup on AWS Side?<br />
<br />
