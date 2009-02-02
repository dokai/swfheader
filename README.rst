===================
SWF metadata parser
===================

This is an Erlang port of the `hexagonit.swfheader
<http://pypi.python.org/pypi/hexagonit.swfheader>`_ package which is a
SWF metadata parser for Python.

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

License
=======

Copyright (c) 2009, Kai Lautaportti
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.

    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.

    * Neither the name of the author nor the names of its contributors
      may be used to endorse or promote products derived from this
      software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
