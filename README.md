## Building

You need to have some prerequisits:

    apt install build-essential gawk unzip libncurses-dev libz-dev libssl-dev wget git subversion

Check out this repository and execute `make`, i.e. like this:

    git clone https://github.com/ffrgb/site-ffrgb.git site-ffrgb
    cd site-ffrgb
    make

### Quick Hints

Some common useful parameters for make:

    GLUON_TARGETS=ar71xx-generic - Only build the specified architecture
    GLUON_GIT_REF=v2018.2.x - wich Gluon-Release version to build
    FORCE_UNSAFE_CONFIGURE=1 - If You build as root in an disposable environment You don't care about
    BROKEN=1 - Also build for untested but defined hardware wich may not work
    V=s - Print more information

Think about starting Your make process inside a `screen` session as it usually takes a long time to build.

## Further Resources

Look at the [site configuration related Gluon documentation](http://gluon.readthedocs.org/en/v2016.2.3/user/site.html)
for information on site configuration options and examples from other communities.
