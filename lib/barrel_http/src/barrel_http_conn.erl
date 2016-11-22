%% Copyright 2016, Bernard Notarianni
%%
%% Licensed under the Apache License, Version 2.0 (the "License"); you may not
%% use this file except in compliance with the License. You may obtain a copy of
%% the License at
%%
%%   http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
%% WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
%% License for the specific language governing permissions and limitations under
%% the License.

-module(barrel_http_conn).
-author("Bernard Notarianni").

-export([peer/2]).

%% @doc returns the peer process for provided dbid
peer(Store, DbId) ->
  %% TODO: remove when plugging new API
  try barrel:database_infos(DbId) of
      {ok, _} -> {ok, DbId}
  catch
    exit:_ ->
      case barrel:open_database(DbId, barrel_lib:to_atom(Store), []) of
        ok -> {ok, DbId};
        {error, not_found} ->
          {error, database_not_found}
      end
  end.