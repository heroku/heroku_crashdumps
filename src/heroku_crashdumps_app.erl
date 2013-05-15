%%%-------------------------------------------------------------------
%%% @author Tristan Sloughter <>
%%% @copyright (C) 2013, Tristan Sloughter
%%% @doc
%%%
%%% @end
%%% Created : 15 May 2013 by Tristan Sloughter <>
%%%-------------------------------------------------------------------
-module(heroku_crashdumps_app).

%% Application callbacks
-export([start/0]).

%%%===================================================================
%%% Application callbacks
%%%===================================================================

start() ->
    setup_crashdumps().

%%%===================================================================
%%% Internal functions
%%%===================================================================

setup_crashdumps() ->
    case dumpdir() of
        undefined -> ok;
        Dir ->
            File = string:join([os:getenv("INSTANCE_NAME"),
                                "boot",
                                datetime(now)], "_"),
            DumpFile = filename:join(Dir, File),
            error_logger:info_msg("at=setup_crashdumps dumpfile=~p", [DumpFile]),
            os:putenv("ERL_CRASH_DUMP", DumpFile)
    end.

dumpdir() ->
    case application:get_env(crashdump_dir) of
        undefined ->
            case os:getenv("ERL_CRASH_DUMP") of
                false -> undefined;
                File -> filename:dirname(File)
            end;
        {ok, Dir} -> Dir
    end.

datetime(now) ->
    datetime(calendar:universal_time());
datetime({_,_,_} = Now) ->
    DT = calendar:now_to_universal_time(Now),
    datetime(DT);
datetime({{Y,M,D},{H,MM,S}}) ->
    io_lib:format("~4.10.0B-~2.10.0B-~2.10.0BT~2.10.0B:~2.10.0B:~2.10.0B"
                 "+00:00",
                 [Y,M,D, H,MM,S]).
