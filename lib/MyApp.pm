package MyApp;
use strict; use warnings;

use Template;
use MyApp::I18N;
use HTTP::Server::Simple::CGI;
use base qw(HTTP::Server::Simple::CGI);

=head1 NAME

MyApp - A very simple web application

=head1 SYNOPSIS

my $app = MyApp->new( $port )->run();

=cut

my %dispatch = (
    '/' => \&index
);

sub index {
    my ( $self, $cgi ) = @_;

    # Must print content type header and then two new lines to begin html content
    print "Content-Type: text/html\r\n\r\n";

    # template->process prints the output unless you pass a var ref as the third param
    return $self->template()->process(
        'index.html.tt',
        {
            # passing in a method to the template, this allows us to set the language so the template
            # doesn't need to know about it
            translate => sub { $self->translate( 'fr', @_ ); }
        }
    ) || $self->template_error();
}

=head2 Template Methods

Methods can be passed as variables into template toolkit for use inside the template

=item C<capitalise_text>

Turns given string into upper case

Usage:

    my $str = 'sausages';
    my $out = capitalise_text( $str );

Out:

    SAUSAGES

=cut

sub capitalise_text {
    my ( $text ) = @_;
    return uc( $text );
}

=item C<translate>

A class method, given a language and a string of text, return any translations we have

Usage:

    my $str = 'hello world';
    my $out = $self->translate( 'fr', $str );

Out:

    sausages

=cut

sub translate {
    my ( $self, $lang, $text ) = @_;
    my $lh = $self->get_language_handle( $lang );
    return $lh->maketext( $text );
}


# Utilities
sub get_language_handle {
    my ( $self, $lang ) = @_;
    return MyApp::I18N->get_handle( $lang );
}

sub handle_request {
    my $self = shift;
    my $cgi  = shift;

    my $path = $cgi->path_info();
    my $handler = $dispatch{$path};

    if (ref($handler) eq "CODE") {
        print "HTTP/1.0 200 OK\r\n";
        $handler->($self,$cgi);
    }
    else {
        print "HTTP/1.0 404 Not found\r\n";
        print $cgi->header,
              $cgi->start_html('Not found'),
              $cgi->h1('Not found'),
              $cgi->end_html;
    }
}

sub template_error {
    my ( $self ) = @_;
    my $error = $self->template()->error();
    warn "error type: ", $error->type(), "\n";
    warn "error info: ", $error->info(), "\n";
    warn $error, "\n";
}

sub template {
    my ( $self ) = @_;

    unless ( $self->{template} ){
        $self->{template} = Template->new({
            INCLUDE_PATH => 'templates',  # or list ref
            VARIABLES => {
                capitalise => \&capitalise_text
            }
        });
    }

    return $self->{template};
}

1;
