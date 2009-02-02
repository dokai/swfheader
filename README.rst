===================
SWF metadata parser
===================

This is an Erlang port of the `hexagonit.swfheader`_ package which is
a SWF metadata parser for Python.

_`http://pypi.python.org/pypi/hexagonit.swfheader/`

Usage
=====

The module exposes two functions. ``parse/1`` parses the the given SWF
file and returns the metadata in a tuple. ``print_header/1`` pretty
prints the metadata in stdout.

You can use the ``parse/1`` function in your own code in the following
way::

    {version, Version,
     compression, Compression,
     width, Width,
     height, Height,
     bbox, {xmin, Xmin, xmax, Xmax, ymin, Ymin, ymax, Ymax},
     frames, Frames,
     fps, Fps} = swfheader:parse("/path/to/the/file.swf").

All items have numeric values except ``compression`` which is either
the atom ``compressed`` or ``uncompressed``.

The ``print_header/1`` function can be used directly from the command
line to quickly inspect the metadata in an SWF file, e.g.::

     $ erl -pa -s swfheader print_header /path/to/the/file.swf -s init stop -noshell

This will print the following to stdout::

     Version: 5
     Compression: uncompressed
     Dimensions: 550.0 x 400.0
     Bounding box: (0.0, 550.0, 0.0, 400.0)
     Frames: 3072
     FPS: 1

The exact values will naturally depend on the particular SWF file.
