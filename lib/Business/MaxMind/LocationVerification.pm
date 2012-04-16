package Business::MaxMind::LocationVerification;

use strict;

use vars qw($VERSION);

use LWP::UserAgent;
use base 'Business::MaxMind::HTTPBase';

# input fields
my @allowed_fields = qw/i city region postal country license_key/;

$VERSION = '1.3';

sub _init {
  my $self = shift;
  $self->{url} = 'app/locvr';
  $self->{check_field} = 'distance';
  $self->{timeout} ||= 10; # provide a default value of 10 seconds for timeout if not set by user
  %{$self->{allowed_fields}} = map {$_ => 1} @allowed_fields
}

1;
__END__

=head1 NAME

Business::MaxMind::LocationVerification - Access free and paid MaxMind Location Verification services

=head1 ABSTRACT

this Module quieries the Location verification service and returns the estimated distance
between the entered city, region and country and the location of the IP address  

=head1 SYNOPSIS

This example queries the Location Verification service and displays the results:

  my $ccfs = Business::MaxMind::LocationVerification->new(isSecure => 1, debug => 0, timeout => 10);
  $locv->input(
    i => '24.24.24.24',
    city => 'NewYork',
    region => 'NY',
    postal => '10011',
    country => 'US')

=head1 METHODS

=over 4

=item new

Class method that returns a Business::MaxMind::LocationVerification object.  If isSecure is set to 1, it will use a
secure connection.  If debug is set to 1, will print debugging output to standard error.  timeout parameter is used
to set timeout in seconds, if absent default value for timeout is 10 seconds.

=item input

Sets input fields.  The input fields are

=begin html

<ul>
  <li><b>i:</b> Client IP Address (IP address of your client)
  <li><b>city, region, postal, country:</b> Entered City/State/ZipCode/Country
</ul>

=end html

Returns 1 on success, 0 on failure.

=item query

Sends out query to MaxMind server and waits for response.  If the primary
server fails to respond, it sends out a request to the secondary server.

=item output

Returns the output returned by the MaxMind server as a hash reference.

=back

=head1 SEE ALSO

L<http://www.maxmind.com/app/locv>

=head1 AUTHOR

TJ Mather, E<lt>tjmather@maxmind.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2008 by MaxMind LLC

All rights reserved.  This package is free software and is licensed under
the GPL.  For details, see the COPYING file.

=cut
