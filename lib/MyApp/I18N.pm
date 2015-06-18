package MyApp::I18N;
use strict; use warnings;
use base qw(Locale::Maketext);

=head1 NAME

MyApp::I18N

=head1 DESCRIPTION

Serves as a base method for our language lexicons

=head1 SYNOPSIS

    my $lh = MyApp::I18N->get_handle($lang);
    my $translated_text = $lh->maketext($str);

=cut

1;
