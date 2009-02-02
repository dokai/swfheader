-module(swfheader).
-export([parse/1, print_header/1, test/0]).

test() ->
    {version, 5,
     compression, uncompressed,
     width, 550.0,
     height, 400.0,
     bbox, {xmin, 0.0, xmax, 550.0, ymin, 0.0, ymax, 400.0},
     frames, 3072,
     fps, 1} = parse("test.swf").

print_header(Filename) ->
    {version, Version,
     compression, Compression,
     width, Width,
     height, Height,
     bbox, {xmin, Xmin, xmax, Xmax, ymin, Ymin, ymax, Ymax},
     frames, Frames,
     fps, Fps} = parse(Filename),
    io:format("Version: ~p~n", [Version]),
    io:format("Compression: ~p~n", [Compression]),
    io:format("Dimensions: ~p x ~p~n", [Width, Height]),
    io:format("Bounding box: (~p, ~p, ~p, ~p)~n", [Xmin, Xmax, Ymin, Ymax]),
    io:format("Frames: ~p~n", [Frames]),
    io:format("FPS: ~p~n", [Fps]).

parse(Filename) ->
    {ok, Swf} = file:read_file(Filename),
    {Compression, Version, _, Payload} = parse_signature(Swf),
    {Xmin, Xmax, Ymin, Ymax, Frames, Fps} = parse_payload(Payload),
    {version, Version,
     compression, Compression,
     width, Xmax-Xmin,
     height, Ymax-Ymin,
     bbox, {xmin, Xmin, xmax, Xmax, ymin, Ymin, ymax, Ymax},
     frames, Frames,
     fps, Fps}.

parse_signature(<<"FWS", Version:8, Size:32/little, Data/binary>>) ->
    {uncompressed, Version, Size, Data};
parse_signature(<<"CWS", Version:8, Size:32/little, Data/binary>>) ->
    {compressed, Version, Size, zlib:gunzip(Data)}.

parse_payload(Payload) ->
    % Extract the RECT field size
    <<Nbits:5/little, _:3, _/binary>> = Payload,
    % Calculate the byte alignment
    ByteAlign = (8 - ((5 + 4 * Nbits) rem 8)) rem 8,
    % Pattern match the RECT element
    <<_:5,
      Xmin:Nbits/big-signed,
      Xmax:Nbits/big-signed,
      Ymin:Nbits/big-signed,
      Ymax:Nbits/big-signed,
      _:ByteAlign,
      Frames:16/little-unsigned,
      Fps:16/little-unsigned,
      _/binary>> = Payload,
    % Convert the RECT values from Twips to pixels
    {Xmin / 20, Xmax / 20, Ymin / 20, Ymax / 20, Frames, Fps}.
