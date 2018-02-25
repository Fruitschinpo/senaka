%%%-------------------------------------------------------------------
%% @doc senaka top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(senaka_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%====================================================================
%% Supervisor callbacks
%%====================================================================

%% Child :: {Id,StartFunc,Restart,Shutdown,Type,Modules}
init(_Args) ->    
    {ok, Port} = application:get_env(senaka, port),
    Flags = #{strategy => one_for_one, intensity => 1, period => 5},
    Children = [child(tcp_server, worker, [Port], [])],
    {ok, {Flags, Children}}.

%%====================================================================
%% Internal functions
%%====================================================================

child(Module, Type, Args, Modules) ->
    #{id => Module,
      start => {Module, start_link, Args},
      restart => permanent,
      shutdown => 5000,
      type => Type,
      modules => Modules}.
