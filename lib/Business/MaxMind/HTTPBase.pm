package Business::MaxMind::HTTPBase;

use 5.005;
use strict;

require Exporter;
use AutoLoader qw(AUTOLOAD);
use vars qw($VERSION $API_VERSION);

use LWP::UserAgent;

$VERSION = '1.2';
$API_VERSION = join('/','Perl',$VERSION);

# we have two servers here in case one goes down
# www should be used by default, www2 is the backup
my @servers = qw/www.maxmind.com www2.maxmind.com/;

sub new {
  my ($class) = shift;
  if ($class eq 'Business::MaxMind::HTTPBase') {
    die "Business::MaxMind::HTTPBase is an abstract class - use a subclass instead";
  }
  my $self = { @_ };
  bless $self, $class;
  $self->{ua} = LWP::UserAgent->new;
  $self->_init;
  return $self;
}

sub query {
  my ($self) = @_;
  for my $server (@servers) {
    my $result = $self->querySingleServer($server);
    return $result if $result;
  }
}

sub input {
  my $self = shift;
  my %vars = @_;
  while (my ($k, $v) = each %vars) {
    unless (exists $self->{allowed_fields}->{$k}) {
      die "invalid input $k - perhaps misspelled field?";
    }
    $self->{queries}->{$k} = $v;
  }
}

sub output {
  my $self = shift;
  return $self->{output};
}

sub querySingleServer {
  my ($self, $server) = @_;
  my $url = ($self->{isSecure} ? 'https' : 'http') . '://' . $server . '/' .
      $self->{url};
  my $queries = $self->{queries};
  my $query_string = join('&', map { "$_=" . $queries->{$_} } keys %$queries);
  $query_string .= "&clientAPI=$API_VERSION";
  if ($self->{"timeout"} > 0){
    $self->{ua}->timeout($self->{"timeout"});
  }  
  my $request = HTTP::Request->new('GET', join('?', $url, $query_string));
  if ($self->{debug}) {
    print STDERR "sending HTTP::Request: " . $request->as_string . " with query_string=" . $query_string;
  }
  my $response = $self->{ua}->request($request);
  if ($response->is_success) {
    my $content = $response->content;
    my @kvpair = split(';',$content);
    my %output;
    for my $kvp (@kvpair) {
      my ($key, $value) = split('=',$kvp,2);
      $output{$key} = $value;
    }
    unless (exists $output{score}) {
      return 0;
    }
    $self->{output} = \%output;
    return 1;
  } else {
    if ($self->{debug}) {
      print STDERR "Error querying $server code: " . $response->code;
    }
    return 0;
  }
}

1;
__END__

=head1 NAME

Business::MaxMind::HTTPBase - Base class for accessing free and paid MaxMind HTTP web services

=head1 ABSTRACT

This is an abstract base class for accessing free and paid MaxMind web services.
Currently there is one subclass, for the Credit Card Fraud Scorer.
There may be another subclass for the Location Verifier in the future.

=head1 METHODS

=over 4

=item new

Class method that returns a new object that is a subclass of Business::MaxMind::HTTPBase.
Will die if you attempt to call this for the Business::MaxMind::HTTPBase class, instead
you should call it on one of its subclasses.

=item input

Sets input fields.  See subclass for details on fields that should be set.
Returns 1 on success, 0 on failure.

=item query

Sends out query to MaxMind server and waits for response.  If the primary
server fails to respond, it sends out a request to the secondary server.

=item output

Returns the output returned by the MaxMind server as a hash reference.

=item error_msg

Returns the error message from an input or query method call.

=back

=head1 SEE ALSO

L<Business::MaxMind::CreditCardFraudDetection>

L<http://www.maxmind.com/app/ccv_overview>

=head1 AUTHOR

TJ Mather, E<lt>tjmather@maxmind.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2004 by MaxMind LLC

All rights reserved.  This package is free software and is licensed under
the GPL.  For details, see the COPYING file.

=cut
