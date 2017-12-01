# SPICE: Simple Protocol for Independent Computing Environments

SPICE is a protocol for remote access to computers.
It consists of several separate components:

* A server which captures frames and sends them to the clients
* Clients render the captured frames and displays them on the local computer
* Agents that run in the (possibly virtual) computer and facilitate
  some aspects of the remote interaction, such as copy-pasting or file
  transfers.
* A special kind of agent, the streaming agent, is designed to capture
  frames as a live video stream using hardware acceleration if
  available in the given computing environment.


This repository is simply a way to access all SPICE components from a
single location.

## Building SPICE

SPICE can be built using two methods at the moment:

* Using just `make`, in which case all dependencies and configurations
  are dealt with using the `c3d/build` makefile-based build system.
  This approach requires `pkg-config`, but not `autoconf` or
  `automake`. It has been tested successfully on Fedora 27 and macOS
  High Sierra. It is generally much faster, and does not require any
  package installation, which makes it the recommended method for
  development that impact multiple components (e.g. protocol changes).
  To use this method, simply type (from the top level):

       make -j

  You can get help about the available build targets with:

       make help

  Additional tips on using this system can be found at
  https://github.com/c3d/build

* Using `autotools`, which will be more familiar for many long-time
  software maintainers. This approach is more suited to installation,
  and requires early-stage components (e.g. spice-protocol) to be
  installed in order to satisfy the dependencies of later modules.
  To build using `autotools`, simply type (form the top level):

       ./autogen.sh "make -j install"

Once you have built with `autogen.sh`, subsequent invokations of
`make` will use the `autotool`-generated makefiles. You can revert at
any time to the `c3d/build` build system using `make restore`.
