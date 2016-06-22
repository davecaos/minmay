
-module(minmay_SUITE).

-export([ all/0
        , init_per_suite/1
        , end_per_suite/1
        , init_per_testcase/2
        ]).

-export([ linear_test_extensions/1
        , ramdon_test_mime_types/1
        , ramdon_test_extensions/1
        , ramdon_test_filenames/1
        , linear_test_mime_types/1
        , linear_test_filenames/1]).

-type config() :: [{atom(), term()}].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Common test
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

-spec all() -> [atom()].
all() ->
  [ linear_test_extensions
  , ramdon_test_mime_types
  , ramdon_test_extensions
  , ramdon_test_filenames
  , linear_test_mime_types
  , linear_test_filenames
  ].

-spec init_per_suite(config()) -> config().
init_per_suite(Config) ->
  Config.

init_per_testcase(_, Config) ->
  ok = minmay:start(),
  Config.

end_per_testcase(_, Config) ->
  ok = minmay:stop(),
  Config.

-spec end_per_suite(config()) -> config().
end_per_suite(Config) ->
  Config.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Exported Tests Functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

-spec linear_test_extensions(config()) -> config().
linear_test_extensions(_Config) ->
  ExtensionsKV  = minmay:extensions(),
  Extensions    = lists:map(fun({Extension, _})-> Extension end, ExtensionsKV),
  FunMatch =
    fun(Extension) -> 
      MimeType = proplists:get_value(Extension, ExtensionsKV),
      MimeType = minmay:from_extension(Extension)
    end,
  lists:map(FunMatch, Extensions),
  {comment, ""}.

-spec linear_test_filenames(config()) -> config().
linear_test_filenames(_Config) ->
  ExtensionsKV  = minmay:extensions(),
  Extensions    = lists:map(fun({Extension, _})-> Extension end, ExtensionsKV),
  FunMatch =
    fun(Extension) -> 
      MimeType = proplists:get_value(Extension, ExtensionsKV),
      MimeType = minmay:from_filename("dummmy_filename" ++ Extension)
    end,
  lists:map(FunMatch, Extensions),
  {comment, ""}.

-spec linear_test_mime_types(config()) -> config().
linear_test_mime_types(_Config) ->
  MimeTypesKV  = minmay:mime_types(),
  MimeTypes    = lists:map(fun({MimeType, _})-> MimeType end,  MimeTypesKV),
  FunMatch =
    fun(MimeType) -> 
      Extension = proplists:get_value(MimeType, MimeTypesKV),
      Extension = minmay:from_mime_type(MimeType)
    end,
  lists:map(FunMatch, MimeTypes),
  {comment, ""}.

-spec ramdon_test_extensions(config()) -> config().
ramdon_test_extensions(_Config) ->
  ExtensionsKV  = minmay:extensions(),
  ExtensionsLen = length(ExtensionsKV),
  RamdonIndexes = [random:uniform(ExtensionsLen) || _ <- lists:seq(1, 10000)],
  FunMatch =
    fun(Index) -> 
      {Extension, MimeType} = lists:nth(Index, ExtensionsKV),
      MimeType = minmay:from_extension(Extension)
    end,
  lists:map(FunMatch, RamdonIndexes),
  {comment, ""}.

-spec ramdon_test_filenames(config()) -> config().
ramdon_test_filenames(_Config) ->
  ExtensionsKV  = minmay:extensions(),
  ExtensionsLen = length(ExtensionsKV),
  RamdonIndexes = [random:uniform(ExtensionsLen) || _ <- lists:seq(1, 10000)],
  FunMatch =
    fun(Index) -> 
      {Extension, MimeType} = lists:nth(Index, ExtensionsKV),
      MimeType = minmay:from_filename( "dummmy_filename" ++ Extension)
    end,
  lists:map(FunMatch, RamdonIndexes),
  {comment, ""}.

-spec ramdon_test_mime_types(config()) -> config().
ramdon_test_mime_types(_Config) ->
  MimeTipesKV    = minmay:mime_types(),
  MimeTipesKVLen = length(MimeTipesKV),
  RamdonIndexes  = [random:uniform(MimeTipesKVLen) || _ <- lists:seq(1, 10000)],
  FunMatch =
    fun(Index) -> 
      {MimeType, Extension} = lists:nth(Index, MimeTipesKV),
      Extension = minmay:from_mime_type(MimeType)
    end,
  lists:map(FunMatch, RamdonIndexes),
  {comment, ""}.