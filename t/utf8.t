#!/usr/bin/env perl

use strict;
use utf8;
use Test::More tests => 3;

use_ok 'Business::MaxMind::CreditCardFraudDetection';

my $ccfs = Business::MaxMind::CreditCardFraudDetection->new(
    isSecure => 1,
    debug    => 1
);

isa_ok $ccfs, 'Business::MaxMind::CreditCardFraudDetection';

$ccfs->input(
    i       => '24.24.24.24',
    domain  => 'yahoo.com',
    city    => 'Oświęcim',
    region  => 'Małopolskie',
    postal  => '32-600',
    country => 'PL',
    bin     => '549099'
);

eval {
    $ccfs->query;
    pass("query with UTF-8");
};
if ($@) {
    fail("query with UTF-8");
    diag($@);
}
