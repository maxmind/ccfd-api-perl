use 5.005;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'Business::MaxMind',
    'VERSION_FROM'	=> 'lib/Business/MaxMind/HTTPBase.pm', # finds $VERSION
    'PREREQ_PM'		=> { LWP::UserAgent => 0 }, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?    ## Add these new keywords supported since 5.005
      (ABSTRACT => 'Business::MaxMind - Access MaxMind minFraud, Telephone and Location verification services', # retrieve abstract from module
       AUTHOR     => 'TJ Mather <tjmather@maxmind.com>') : ()),
);
