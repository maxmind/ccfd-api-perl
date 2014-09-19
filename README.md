# NAME

Business::MaxMind::HTTPBase - Base class for accessing HTTP web services

# VERSION

version 1.55

# DESCRIPTION

This is an abstract base class for accessing MaxMind web services.
Currently there are three subclasses, for Credit Card Fraud Detection,
Telephone Verification and Location Verification.  This class can be
used for other HTTP based web services as well.

# METHODS

- new

    Class method that returns a new object that is a subclass of Business::MaxMind::HTTPBase.
    Will die if you attempt to call this for the Business::MaxMind::HTTPBase class, instead
    you should call it on one of its subclasses.

- input

    Sets input fields.  See subclass for details on fields that should be set.
    Returns 1 on success, 0 on failure.

- query

    Sends out query to MaxMind server and waits for response.  If the primary
    server fails to respond, it sends out a request to the secondary server.
    Returns 1 on success, 0 on failure.

- output

    Returns the output returned by the MaxMind server as a hash reference.

# SEE ALSO

[Business::MaxMind::CreditCardFraudDetection](https://metacpan.org/pod/Business::MaxMind::CreditCardFraudDetection)

[https://www.maxmind.com/en/minfraud-services](https://www.maxmind.com/en/minfraud-services)

# AUTHORS

- TJ Mather <tjmather@maxmind.com>
- Frank Mather <frank@maxmind.com>

# COPYRIGHT AND LICENSE

This software is Copyright (c) 2014 by MaxMind, Inc..

This is free software, licensed under:

    The GNU General Public License, Version 2, June 1991
