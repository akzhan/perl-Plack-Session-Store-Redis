[![Build Status](https://travis-ci.org/akzhan/perl-Plack-Session-Store-RedisFast.svg?branch=master)](https://travis-ci.org/akzhan/perl-Plack-Session-Store-RedisFast)
[![codecov](https://codecov.io/gh/akzhan/perl-Plack-Session-Store-RedisFast/branch/master/graph/badge.svg)](https://codecov.io/gh/akzhan/perl-Plack-Session-Store-RedisFast)
[![Cpan license](https://img.shields.io/cpan/l/Plack-Session-Store-RedisFast.svg)](https://metacpan.org/release/Plack-Session-Store-RedisFast)
[![Cpan version](https://img.shields.io/cpan/v/Plack-Session-Store-RedisFast.svg)](https://metacpan.org/release/Plack-Session-Store-RedisFast)

# NAME

Plack::Session::Store::RedisFast - Redis session store.

# DESCRIPTION

Default implementation of Redis handle is [Redis::Fast](https://metacpan.org/pod/Redis::Fast); otherwise [Redis](https://metacpan.org/pod/Redis).

May be overriden through ["redis"](#redis) or  ["builder"](#builder) param.

Default implementation of serializer handle is [JSON::XS](https://metacpan.org/pod/JSON::XS); otherwise [JSON](https://metacpan.org/pod/JSON).

May be overriden through ["inflate"](#inflate) and ["deflate"](#deflate) param.

# SYNOPSIS

    use Plack::Builder;
    use Plack::Session::Store::RedisFast;

    my $app = sub {
        return [ 200, [ 'Content-Type' => 'text/plain' ], [ 'Hello Foo' ] ];
    };

    builder {
        enable 'Session',
            store => Plack::Session::Store::RedisFast->new;
        $app;
    };

# DESCRIPTION

This will persist session data using [Redis::Fast](https://metacpan.org/pod/Redis::Fast) or [Redis](https://metacpan.org/pod/Redis).

This is a subclass of [Plack::Session::Store](https://metacpan.org/pod/Plack::Session::Store) and implements
its full interface.

# METHODS

## new

    Plack::Session::Store::RedisFast->new( %params )>

Parameters:

- redis

    A simple accessor for the Redis handle.

- builder

    A simple builder for the Redis handle if ["redis"](#redis) not set.

- inflate

    A simple serializer, JSON::XS->new->utf8->allow\_nonref->encode
    or JSON->new->utf8->allow\_nonref->encode by default.

- deflate

    A simple deserializer, JSON::XS->new->utf8->allow\_nonref->decode
    or JSON->new->utf8->allow\_nonref->decode by default.

- prefix

    A prefix for Redis session ids. 'Plack::Session::Store::RedisFast:' by default.

- expire

    An expire for Redis sessions. ["ONE\_MONTH" in Time::Seconds](https://metacpan.org/pod/Time::Seconds#ONE_MONTH) by default.

# BUGS

All complex software has bugs lurking in it, and this module is no
exception. If you find a bug please fill in GitHub issues.

# AUTHOR

Akzhan Abdulin <akzhan.abdulin@gmail.com>

# COPYRIGHT

Copyright 2017- Akzhan Abdulin

# LICENSE

MIT License
