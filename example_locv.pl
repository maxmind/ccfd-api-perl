#!/usr/bin/perl -Ilib -Iblib/lib

use strict;
use Business::MaxMind::LocationVerification;

# Enter your license key here
my $license_key = 'ENTER_LICENSE_KEY_HERE';

#isSecure 
#if it is 0 then use Regalur HTTP
#if it is 1 then use Secure HTTP
#debug
#if it is 0 then print no debuging info
#if it is 1 then print debuging info
#timeout 
#the time in seconds to wait before timing out 
my $locv = Business::MaxMind::LocationVerification->new(isSecure => 1,
debug => 1,timeout => 5);
$locv->input(
		# required fields
		i => '24.24.24.24',
                city => 'NewYork',
                region => 'NY',
                postal => '10011',
                country => 'US',

#		license_key => $license_key
              );
$locv->query;
my $hash_ref = $locv->output;

use Data::Dumper;
print Dumper($hash_ref);
