
-module(minmay_SUITE).

-author("David Cesar Hernan Cao <david.c.h.cao@gmail.com>").
-github("https://github.com/davecaos").
-license("MIT").

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
      MimeType = minmay:from_filename("dummmy_filename." ++ Extension)
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
  ExtensionsKV    = minmay:extensions(),
  ExtensionsLen   = length(ExtensionsKV),
  IndexList       = lists:zip( lists:seq(1, ExtensionsLen), ExtensionsKV ),
  MapExtensionsKV = maps:from_list(IndexList),
  RamdonIndexes   = for(100000, ExtensionsLen),
  FunMatch =
    fun(Index) ->
      {Extension, MimeType} = maps:get(Index, MapExtensionsKV),
      MimeType = minmay:from_extension(Extension)
    end,
  lists:map(FunMatch, RamdonIndexes),
  {comment, ""}.

-spec ramdon_test_filenames(config()) -> config().
ramdon_test_filenames(_Config) ->
  ExtensionsKV    = minmay:extensions(),
  ExtensionsLen   = length(ExtensionsKV),
  IndexList       = lists:zip( lists:seq(1, ExtensionsLen), ExtensionsKV ),
  MapExtensionsKV = maps:from_list(IndexList),
  RamdonIndexes   = for(100000, ExtensionsLen),
  FunMatch =
    fun(Index) ->
      {Extension, MimeType} = maps:get(Index, MapExtensionsKV),
      MimeType = minmay:from_filename( "dummmy_filename." ++ Extension)
    end,
  lists:map(FunMatch, RamdonIndexes),
  {comment, ""}.

-spec ramdon_test_mime_types(config()) -> config().
ramdon_test_mime_types(_Config) ->
  MimeTipesKV    = minmay:mime_types(),
  MimeTipesKVLen = length(MimeTipesKV),
  IndexList      = lists:zip( lists:seq(1, MimeTipesKVLen), MimeTipesKV ),
  MapMimeTipesKV = maps:from_list(IndexList),
  RamdonIndexes  = for(100000, MimeTipesKVLen),
  FunMatch =
    fun(Index) ->
      {MimeType, Extension} = maps:get(Index, MapMimeTipesKV),
      Extension = minmay:from_mime_type(MimeType)
    end,
  lists:map(FunMatch, RamdonIndexes),
  {comment, ""}.

for(0, _Range) ->
   [];
for(N,Range) when N > 0 ->
   Random = random:uniform(Range),
   [Random | for(N-1,Range)].
