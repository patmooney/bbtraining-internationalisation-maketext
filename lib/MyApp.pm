package MyApp;
use strict; use warnings;

use Template;
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
    return $self->template()->process('index.html.tt') || $self->template_error();
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

sub translate {

}

# Utilities

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
