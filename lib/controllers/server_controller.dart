import 'dart:collection';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vpn_countries/models/logical_server.dart';
import 'package:vpn_countries/repositories/server_repository.dart';
import 'package:vpn_countries/utils/extensions.dart';

final serversControllerProvider =
    StateNotifierProvider<ServerController>((ref) {
  final serverRepository = ref.read(serverRepositoryProvider);
  return ServerController(serverRepository);
});

class ServerController extends StateNotifier<ServerControllerModel> {
  ServerController(this._serverRepository) : super(_initialState) {
    getServers();
  }

  static final _initialState = ServerControllerModel({});

  final ServerRepository _serverRepository;

  Future<void> getServers() async {
    final servers = await _serverRepository.fetch();
    final removeNullCity = servers.where((x) {
      return x.city != null;
    }).toList();
    // Currently, we can not test the compute function, will update once have the solution
    // final groupByCountry = await compute(orderServers, removeNullCity);
    final groupByCountry = orderServers(removeNullCity);
    state = ServerControllerModel(groupByCountry);
  }
}

Map<String, List<LogicalServer>> orderServers(List<LogicalServer> servers) {
  // groupped unordered servers by entryCountry
  final groupByCountry = servers.groupBy(
    (server) => server.entryCountry,
  );
  // ascending order
  final orderKeys = groupByCountry.keys.toList()..sort();
  // build a LinkedHashMap from orderKeys
  final orderByCountry = LinkedHashMap.fromIterable(
    orderKeys,
    key: (k) => k as String,
    value: (v) => groupByCountry[v],
  );
  return orderByCountry;
}

class ServerControllerModel {
  ServerControllerModel(
    this.servers,
  );

  final Map<String, List<LogicalServer>> servers;
}
