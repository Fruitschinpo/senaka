-module(parser).

-export(parse_xml/1, write_xml/2).

write_xml(Data, "stream") ->
    io:format("Writing stream");
write_xml(Data, "message") ->
    io:format("Writing message").

parse_xml(String) ->
    xmerl_scan:string(String).
