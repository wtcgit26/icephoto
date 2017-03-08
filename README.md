# icephoto

usage: icephoto.sh [--verbose] [--description \"archive description\"] [--account-id aws_account-id] --vault-name aws_vault-name --size part_size[k|m] --filename input_file
aws_account-id if blank will be '-'
part_size == can be 1000k for 1000 kilobytes or 250m for 250 megabytes (e.g. split byte command)
input_file == archive file to be split and uploaded (typically a .gz file)

Created: 5 March 2017

Purpose: 
Split gz file into chunks
Send Photo Archives up to Amazon Glacier
Returns verbose output to stdout

Actions:
-- Cleanup the output so that it json compliant
-- Error handling on the AWS Side
-- Account Setup on AWS Side?

