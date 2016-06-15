-module(minmay).

-export([start/0, stop/0]).

-export([get_extension/1]).
-export([get_mime_type/1]).

start() ->
  {ok, _Started} = application:ensure_all_started(minmay),
  ok = load_ets(extensions),
  ok = load_ets(mime_types).

stop() ->
  ok = ets:delete(extensions),
  ok = ets:delete(mime_types).

get_mime_type(FileName) ->
  FileExtension = filename:extension(FileName),
  [{_FileExtension, MimeType}] = ets:lookup(extensions, FileExtension),
  MimeType.

get_extension(MimeType) ->
  [{MimeType, FileExtension}] = ets:lookup(mime_types, MimeType),
  FileExtension.

load_ets(EtsName) ->
  EtsName = ets:new(EtsName, [set, named_table, protected]),
  {ok, KvList} = application:get_env(minmay, EtsName),
  true = ets:insert(EtsName, KvList),
  ok.