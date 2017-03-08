#!/usr/bin/perl

# Created: 7 March 2017
# Purpose: 
# Parse output from icephoto.sh 
# The log file is poorly written so needed to parse into a json
# Eventually this will not be necessary.

use strict;
use warnings;
# 
# using global string variables so that they will survive past each line pull in the file
#
my $starttime = "error--foo--error";
my $description = "error--foo--error";
my $vaultname = "error--foo--error";
my $archiveid = "error--foo--error";
my $checksum = "error--foo--error";
my $location = "error--foo--error";
my $endtime = "error--foo--error";
#
# using a local file here. Could have used STDIN
#
# my $filename = './glacier-command.log';
# open(my $fh, '<:encoding(UTF-8)', $filename)
#   or die "Could not open file '$filename' $!";
#
# Once it Sees the Part xx Finished line - it dumps a json to the screen
#
while (my $row = <STDIN>) {
  	chomp $row;
	if ($row =~ m/^Part [0-9]* Start: (.*$)/) 
	{
  		$starttime = $1;
		# print "Start Time: $starttime\n";
  	}
	if ($row =~ m/^command.*--archive-description *'(.*)'/) 
	{
  		$description = $1;
		# print "Description: $description\n";
  	}
	if ($row =~ m/^command.*--vault-name *(\S*)/) 
	{
  		$vaultname = $1;
		# print "Vault Name: $vaultname\n";
  	}
	if ($row =~ m/^ *"archiveId": *"(\S*)"/) 
	{
  		$archiveid = $1;
		# print "ArchiveID: $archiveid\n";
  	}
	if ($row =~ m/^ *"checksum": *"(\S*)"/) 
	{
  		$checksum = $1;
		# print "Checksum: $checksum\n";
  	}
	if ($row =~ m/^ *"location": *"(\S*)"/) 
	{
  		$location = $1;
		# print "Location: $location\n";
  	}
	if ($row =~ m/^Part [0-9]* Finished: (.*$)/) 
	{
  		$endtime = $1;
		print "\n{\n";
	  	print "\t\"StartTime\" : \"$starttime\"\n"; 
	  	print "\t\"EndTime\" : \"$endtime\"\n"; 
	  	print "\t\"Description\" : \"$description\"\n"; 
	  	print "\t\"VaultName\" : \"$vaultname\"\n"; 
	  	print "\t\"ArchiveID\" : \"$archiveid\"\n"; 
	  	print "\t\"Checksum\" : \"$checksum\"\n"; 
	  	print "\t\"Location\" : \"$location\"\n"; 
	  	print "}\n";
	  	print "\n";
	  	$starttime = "error--foo--error";
		$description = "error--foo--error";
		$vaultname = "error--foo--error";
		$archiveid = "error--foo--error";
		$checksum = "error--foo--error";
		$location = "error--foo--error";
		$endtime = "error--foo--error";
  	}
  	
}