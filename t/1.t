# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 1.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
use strict;
BEGIN { plan tests => 1 }
use Business::MaxMind::CreditCardFraudDetection;
ok(1);    # If we made it this far, we're ok.
my $ccfs = Business::MaxMind::CreditCardFraudDetection->new(
    isSecure => 1,
    debug    => 1
);
$ccfs->input(
    i       => '24.24.24.24',
    domain  => 'yahoo.com',
    city    => 'NewYork',
    region  => 'NY',
    postal  => '10011',
    country => 'US',
    bin     => '549099',
);
$ccfs->query;
my $hash_ref = $ccfs->output;

use Data::Dumper;
print Dumper($hash_ref);

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

