Installing AEGeAn
=================


For the impatient
-----------------

.. code-block:: bash

    # Install pre-requisite packages with your OS's package manager
    sudo apt-get install -y build-essential git libcairo2-dev libpango1.0-dev

    # Download, compile, and install the GenomeTools package
    curl -O http://genometools.org/pub/genometools-1.5.4.tar.gz
    tar xzf genometools-1.5.4.tar.gz
    cd genometools-1.5.4
    make 64bit=yes
    sudo make 64bit=yes install
    cd ..

    # Make sure that the compiler/linker can find the GenomeTools library
    sudo sh -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/genometools-x86_64.conf'
    sudo ldconfig

    # Download, compile, and install the  AEGeAn Toolkit
    curl https://github.com/standage/AEGeAn/archive/v0.11.0.tar.gz > AEGeAn-0.11.0.tar.gz
    tar xzf AEGeAn-0.11.0.tar.gz
    cd AEGeAn-0.11.0
    make test
    sudo make install
    sudo ldconfig # Update linker config again


Prerequisites
-------------
In principle, AEGeAn should compile and run on any POSIX-compliant UNIX system
(Linux, Mac OS X, Cygwin), although in practice, it has only been tested on
Linux and Mac systems. Native Windows support is not anticipated any time soon.

We have made an effort to minimize dependency on external software. Aside from
the GenomeTools library (which is included in the AEGeAn source code
distribution), compiling and installing AEGeAn requires only GNU make and a C
compiler.

While not a strict requirement, fully leveraging the graphics capabilities
provided by AEGeAn (through GenomeTools) requires that the system also have an
installation of the Cairo graphics library (see "`Appendix: system setup`_" for
platform-specific installation instructions).


Downloading
-----------
Official stable releases of the AEGeAn Toolkit can be downloaded from the 
`Releases tab <https://github.com/standage/AEGeAn/releases>`_ on the AEGeAn
GitHub page. Alternatively, you can always download the latest and greatest
version of AEGeAn (most recently updates, though not guaranteed to be stable)
by cloning the Git repository.

.. code-block:: bash

    git clone https://github.com/standage/AEGeAn.git

**Note**: AEGeAn uses `Semantic Versioning <http://semver.org>`_ for labeling
stable releases.


Compiling and installing
------------------------

The instructions under the section labeled "`For the impatient`_" are a good
starting point for most users. Chances are many users will be able to
successfully install by running those commands verbatim. The first few commands
are specific to Debian-based Linux operating systems such as Ubuntu.
If you are using a different operating system, please see "`Appendix:
system setup`_"  for platform-specific instructions. After running those
commands, complete the installation by running ``make`` and ``make install``.

See the section labeled `Compilation flags`_ for a complete description of
configurable settings for compilation and installation.

Compilation flags
~~~~~~~~~~~~~~~~~

Compilation settings can be configured using the following flags with the
``make`` command.

* ``64bit=no``: do not compile for a 64-bit architecture
* ``cairo=no``: compile without graphics support (if your system does not have
  the Cairo graphics libraries installed)
* ``prefix=$DIR``: install AEGeAn in ``$DIR`` rather than the default directory
  ``/usr/local``; it is expected that GenomeTools is installed with the same
  prefix
* ``optimize=yes``: enable performance optimization for the AEGeAn code
* ``errorcheck=no``: allow code to compile even if there are warnings
* ``debug=no``: disable debugging support
* ``clean``: remove all compiler-generated files

For example, if you want to compile the code with performance optimizations
enabled and graphics support disabled, run ``make optimize=yes cairo=no``
instead of just ``make``.

Compiling without administrative privileges
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The default installation location is ``/usr/local/``, which means:

* programs are installed in ``/usr/local/bin``
* header files are installed in ``/usr/local/include``
* libraries are installed in ``/usr/local/lib``
* auxiliary data files are installed in ``/usr/local/share``

If you do not have administrative privileges on your machine, then you will not
be able to run ``make install`` without specifying an alternative installation
directory with ``prefix``. Creating an installation directory within your home
directory, as shown in the following example, is recommended.

.. code-block:: bash

  mkdir ~/local
  make prefix=~/local
  make prefix=~/local install

This will install the programs in ``~/local/bin``, the libraries in
``~/local/lib``, etc. You will probably want to add ``~/local/bin`` to your
``PATH`` environmental variable and ``~/local/lib`` to your ``LD_LIBRARY_PATH``
environmental variable (or ``DYLD_LIBRARY_PATH`` on Mac OS X).

.. _appendix-config:

Appendix: system setup
----------------------
Below are instructions for installing prerequisites and configuring system paths
for the most common operating systems. Note that running these commands requires
administrative/sudo privileges.

* Debian-based systems including Ubuntu, Mint/LMDE, etc (tested on Ubuntu 11.10)

  .. code-block:: bash
  
      sh -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/aegean-x86_64.conf'
      ldconfig
      apt-get install -y build-essential git libcairo2-dev libpango1.0-dev

* Red Hat-based systems including CentOS, Fedora, etc (tested on CentOS 5.3)

  .. code-block:: bash
  
      sh -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/aegean-x86_64.conf'
      /sbin/ldconfig
      yum install -y git cairo-devel pango-devel

* Mac OS X

  .. code-block:: bash
  
      # Install Homebrew: http://brew.sh/
      # Then use the brew command to install GenomeTools
      brew install genometools
      
