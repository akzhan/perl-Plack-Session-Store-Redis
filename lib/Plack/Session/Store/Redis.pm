package Plack::Session::Store::Redis;

use strict;
use warnings;

use 5.008_005;

use Carp qw( carp );
use Plack::Util::Accessor qw( prefix redis inflate deflate expire );
use Time::Seconds qw( ONE_MONTH );

use parent 'Plack::Session::Store';

our $VERSION   = '0.01';
our $AUTHORITY = 'cpan:AKZHAN';

sub new {
    my ( $class, %param ) = @_;
    $param{prefix} = __PACKAGE__ . ':' unless defined $param{prefix};
    $param{expire} = ONE_MONTH         unless exists $param{expire};

    $param{inflate} ||= \&_inflate;
    $param{deflate} ||= \&_deflate;

    unless ( $param{redis} ) {
        my $builder = $param{builder} || \&_build_redis;
        delete $param{builder};
        $param{redis} = $builder->();
    }

    bless {%param} => $class;
}

sub _build_redis {
    my $instance;
    eval {
        require Redis::Fast;
        $instance = Redis::Fast->new;
        1;
    } or do {
        require Redis;
        $instance = Redis->new;
    };
    $instance;
}

sub _build_encoder {
    my $instance;
    eval {
        require JSON::XS;
        $instance = JSON::XS->new->utf8->allow_nonref;
        1;
    } or do {
        require JSON;
        $instance = JSON->new->utf8->allow_nonref;
    };
    $instance;
}

my $_encoder = undef;

sub _encoder {
    $_encoder ||= _build_encoder();
}

sub _inflate {
    my ($session) = @_;
    _encoder->encode($session);
}

sub _deflate {
    my ($data) = @_;
    _encoder->decode($data);
}

sub fetch {
    my ( $self, $session_id ) = @_;
    my $data = $self->redis->get( $self->prefix . $session_id );
    return undef unless defined $data;
    $self->deflate->($data);
}

sub store {
    my ( $self, $session_id, $session ) = @_;
    unless ( defined $session ) {
        carp "store: no session provided";
        return;
    }
    my $data = $self->inflate->($session);
    $self->redis->set(
        $self->prefix . $session_id => $data,
        ( defined( $self->expire ) ? ( EX => $self->expire ) : () ),
    );
}

sub remove {
    my ( $self, $session_id ) = @_;
    $self->redis->del( $self->prefix . $session_id );
}

1;

__END__

=pod

=encoding utf-8


=head1 NAME

Plack::Session::Store::Redis - Redis session store

=head1 SYNOPSIS

  use Plack::Builder;
  use Plack::Session::Store::Redis;

  my $app = sub {
      return [ 200, [ 'Content-Type' => 'text/plain' ], [ 'Hello Foo' ] ];
  };

  builder {
      enable 'Session',
          store => Plack::Session::Store::Redis->new;
      $app;
  };

=head1 DESCRIPTION

This will persist session data using L<Redis::Fast> or L<Redis>.

This is a subclass of L<Plack::Session::Store> and implements
its full interface.

=head1 METHODS

=over 4

=item B<new ( %params )>

=item B<redis>

A simple accessor for the Redis handle.

=back

=head1 BUGS

All complex software has bugs lurking in it, and this module is no
exception. If you find a bug please fill in GitHub issues.

=head1 AUTHOR

Akzhan Abdulin E<lt>akzhan.abdulin@gmail.comE<gt>

=head1 COPYRIGHT

Copyright 2017- Akzhan Abdulin

=head1 LICENSE

MIT License

=cut
