
-module(minmay_SUITE).

-export([ all/0
        , init_per_suite/1
        , end_per_suite/1
        , init_per_testcase/2
        ]).

-export([linear_test/1, ramdon_test/1]).

-type config() :: [{atom(), term()}].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Common test
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

-spec all() -> [atom()].
all() ->
  [linear_test, ramdon_test].

-spec init_per_suite(config()) -> config().
init_per_suite(Config) ->
  ok = minmay:start(),
  Config.

init_per_testcase(_, Config) ->
  Config.

-spec end_per_suite(config()) -> config().
end_per_suite(Config) ->
  Config.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Exported Tests Functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

-spec linear_test(config()) -> _.
linear_test(_Config) ->
  ExtensionsKV = minmay:extensions(),
  Extensions = lists:map(fun({Extension, _})-> Extension end, ExtensionsKV),
  ExtensionsLen = size(Extensions),
  FunMatch =
    fun(Extension) -> 
      proplists:get_value(Extension, ExtensionsKV) = minmay:get_extension(Extension)
    end,
  lists:map(FunMatch, Extension),
  {comment, ""}.

-spec ramdon_test(config()) -> _.
ramdon_test(_Config) ->
  ExtensionsKV = minmay:extensions(),
  ExtensionsLen = size(ExtensionsKV),
  RamdonIndexes = [random:uniform(ExtensionsLen) || _ <- lists:seq(1, 10000)],
  FunMatch =
    fun(Index) -> 
      {Extension, MimeType} = lists:nth(Index, ExtensionsKV)
      MimeType = minmay:get_extension(Extension)
    end,
  lists:map(FunMatch, Extension),
  {comment, ""}.