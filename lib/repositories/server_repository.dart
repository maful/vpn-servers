import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vpn_countries/models/logical_server.dart';
import 'package:vpn_countries/services/server_api.dart';

final serverRepositoryProvider = Provider<ServerRepository>((ref) {
  final serverApi = ref.watch(serverApiProvider);

  return ServerRepository(serverApi);
});

class ServerRepository {
  ServerRepository(this._serverApi);

  final ServerApi _serverApi;

  List<LogicalServer> parseServers(String responseBody) {
    final parsed = json.decode(responseBody);
    final serversParsed = parsed['LogicalServers'] as List<dynamic>;
    List<LogicalServer> servers =
        serversParsed.map((model) => LogicalServer.fromJson(model)).toList();
    return servers;
  }

  Future<List<LogicalServer>> fetch() async {
    final response = await _serverApi.fetchLogicalServers();
    return parseServers(response.body);
  }
}
