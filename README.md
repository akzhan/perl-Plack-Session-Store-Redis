# NAME

Plack::Session::Store::Redis - Redis session store

# SYNOPSIS

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

# DESCRIPTION

This will persist session data using [Redis::Fast](https://metacpan.org/pod/Redis::Fast) or [Redis](https://metacpan.org/pod/Redis).

This is a subclass of [Plack::Session::Store](https://metacpan.org/pod/Plack::Session::Store) and implements
its full interface.

# METHODS

- **new ( %params )**
- **redis**

    A simple accessor for the Redis handle.

# BUGS

All complex software has bugs lurking in it, and this module is no
exception. If you find a bug please fill in GitHub issues.

# AUTHOR

Akzhan Abdulin <akzhan.abdulin@gmail.com>

# COPYRIGHT

Copyright 2017- Akzhan Abdulin

# LICENSE

MIT License
