[![Build Status](https://travis-ci.org/akzhan/perl-Plack-Session-Store-RedisFast.svg?branch=master)](https://travis-ci.org/akzhan/perl-Plack-Session-Store-RedisFast)
[![codecov](https://codecov.io/gh/akzhan/perl-Plack-Session-Store-RedisFast/branch/master/graph/badge.svg)](https://codecov.io/gh/akzhan/perl-Plack-Session-Store-RedisFast)

# NAME

Plack::Session::Store::RedisFast - Redis session store.

# DESCRIPTION

Default implementation of Redis handle is [Redis::Fast](https://metacpan.org/pod/Redis::Fast); otherwise [Redis](https://metacpan.org/pod/Redis).

May be overriden through ["redis"](#redis) param.

Default implementation of serializer handle is [JSON::XS](https://metacpan.org/pod/JSON::XS); otherwise [Mojo::JSON](https://metacpan.org/pod/Mojo::JSON) or [JSON](https://metacpan.org/pod/JSON).

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

    Plack::Session::Store::RedisFast->new( %param );

Parameters:

- redis

    A simple accessor for the Redis handle.

- inflate

    A simple serializer, requires ["deflate"](#deflate) param.

- deflate

    A simple deserializer, requires ["inflate"](#inflate) param.

- encoder

    A simple encoder (encode/decode implementation), class or instance. JSON/utf8 by default.

- prefix

    A prefix for Redis session ids. 'Plack::Session::Store::RedisFast:' by default.

- expire

    An expire for Redis sessions. ["ONE\_MONTH" in Time::Seconds](https://metacpan.org/pod/Time::Seconds#ONE_MONTH) by default.

## each\_session

    $store->each_session(sub {
        my ( $redis_instance, $redis_prefix, $session_id, $session ) = @_;
    });

Enumerates all stored sessions using SCAN, see [https://redis.io/commands/scan](https://redis.io/commands/scan) for limitations.

# BUGS

All complex software has bugs lurking in it, and this module is no
exception. If you find a bug please fill in GitHub issues.

# AUTHOR

Akzhan Abdulin <akzhan.abdulin@gmail.com>

# COPYRIGHT

Copyright 2017- Akzhan Abdulin

# LICENSE

MIT License
