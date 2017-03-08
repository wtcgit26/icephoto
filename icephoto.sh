#!/bin/bash
#
# Created: 5 March 2017
#
# Purpose: 
# Split gz file into chunks
# Send Photo Archives up to Amazon Glacier
# Returns verbose output to stdout
#
# Actions:
# -- Cleanup the output so that it json compliant
# -- Error handling on the AWS Side
# -- Account Setup on AWS Side?
#
progname=$0
# time of the start of the program
startdate=`exec date`
# default description if nothing flagged
description="STLC Archive Started $startdate"
# part delineator
filename="foo.bar"
partname="-part-"
verbose=0
#
# aws details
awsaccountid="-"
awsvaultname="foo"
#
#
# function used for the help request
function usage
{
    echo "usage: $progname [--verbose] [--description \"archive description\"] [--account-id aws_account-id] --vault-name aws_vault-name --size part_size[k|m] --filename input_file"
    echo "aws_account-id if blank will be '-'"
    echo "part_size == can be 1000k for 1000 kilobytes or 250m for 250 megabytes (e.g. split byte command)"
    echo "input_file == archive file to be split and uploaded (typically a .gz file)"
}
#
#
# decipher command line arguments
# from http://linuxcommand.org/wss0130.php
while [ "$1" != "" ]; do
    case $1 in
        -f | --filename )       shift
                                filename=$1
                                ;;
        -d | --description )	shift
								description=$1
								;;
		-s | --size )			shift
								partsize=$1
								;;
		-a | --account-id )		shift
								awsaccountid=$1
								;;
		-n | --vault-name )		shift
								awsvaultname=$1
								;;
        -v | --verbose )        verbose=1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done
#
# Error Checking
if [ -s $filename ] && [ -n $partsize ]
then
	echo "========================================================="
	echo
	echo
	echo $description
	echo
	echo
	echo "========================================================="
	echo
	echo "Archive Started: $startdate"
else
	usage
	exit 1
fi
#
# split call
archivename=$filename$partname
if [ $verbose -eq 1 ]
then
	echo
	echo "Split Archive File"
	echo
	echo "command == split -b $partsize $filename $archivename 2>&1"
fi
#
# Payload Command -- Splits the archive file into parts
# 6mar -- added redirection of stderr to stdout so that any errors go to log
split -b $partsize $filename $archivename 2>&1
#
#
if [ $verbose -eq 1 ]
then
	echo
	echo "Finished Split Archive File"
	echo
fi
#
arraypartfiles=($archivename*)
num=0
for i in "${arraypartfiles[@]}"
do
	:
	((num++))
	idescription="$description -- Part $num"
	if [ $verbose -eq 1 ]
	then
	   echo
	   echo "Part $num Start: `exec date`"
	   echo
	   echo $idescription
	   echo "command == aws glacier upload-archive --account-id $awsaccountid --vault-name $awsvaultname --archive-description '$idescription' --body $i 2>&1"
	   echo
	fi
#
# Payload Command - This uploads to Amazon Glacier
# Puts stderr and stdout into stdout so that the output can be piped
aws glacier upload-archive --account-id $awsaccountid --vault-name $awsvaultname --archive-description '$idescription' --body $i 2>&1
#
#
	if [ $verbose -eq 1 ]
	then
	   echo
	   echo "Part $num Finished: `exec date`"
	   echo
	fi
done
#
#
echo
echo "Archive Completed: `exec date`"
echo
#
#