#!/bin/perl

use strict;
use warnings;
use LWP::UserAgent;
use HTTP::Request;
##Output file location##
my $opdir='/home/******/ServiceOutput';

##Open a txt file to capture Status
open(my $fh1, '>', "${opdir}/AWSWebserviceStatus.txt");

##Calling Functions
#GetCRMProductOffers();

##Create an array of Requests
my %requests = (); ##Paste your requests in brackets 

##Loop through Array
foreach my $key (keys(%requests)) 
{
	ProcessRequest($key,$requests{$key});

}

##Function to run the request and get response#

sub ProcessRequest
{

	my ($ServiceName, $message) = @_;

	my $userAgent = LWP::UserAgent->new();
	my $request = HTTP::Request->new(POST => '<Service End Point URL>');
	$request->header(SOAPAction => '""');
	$request->content($message);
	$request->content_type("text/xml; charset=utf-8");

	my $response = $userAgent->request($request);


	if($response->code == 200)
	{
		open(my $fh, '>', "${opdir}/${ServiceName}.xml");
		print $fh $response->as_string;
		close $fh;
		print $fh1 "AWS_sit1_Chordiant;${ServiceName};Passed\n";

	}	
	else
	{
		open(my $fh2, '>', "${opdir}/${ServiceName}_Error.xml");
		print $fh2 $response->as_string;
		close $fh2;
		print $fh1 "AWS_sit1_Chordiant;${ServiceName};Failed\n";
	}
}

close $fh1;

