import 'package:vpn_countries/models/location.dart';
import 'package:vpn_countries/models/logical_server.dart';
import 'package:vpn_countries/models/server.dart';
import 'package:vpn_countries/repositories/server_repository.dart';

class FakeServerRepository implements ServerRepository {
  @override
  Future<List<LogicalServer>> fetch() async {
    return [
      LogicalServer(
        name: "CA#1",
        entryCountry: "CA",
        exitCountry: "CA",
        domain: "ca-01.protonvpn.com",
        region: null,
        city: "Toronto",
        location: Location(lat: 43.63, long: -79.11),
        status: 1,
        servers: [
          Server(
            entryIp: "104.254.92.59",
            exitIp: "104.254.92.59",
            domain: "ca-01",
          )
        ],
        load: 89,
        score: 2.8403,
      ),
      LogicalServer(
        name: "AR#1",
        entryCountry: "AR",
        exitCountry: "AR",
        domain: "ca-01.protonvpn.com",
        region: null,
        city: "Texas",
        location: Location(lat: 43.63, long: -79.11),
        status: 1,
        servers: [
          Server(
            entryIp: "104.254.92.59",
            exitIp: "104.254.92.59",
            domain: "ca-01",
          )
        ],
        load: 89,
        score: 2.8403,
      )
    ];
  }

  @override
  List<LogicalServer> parseServers(String responseBody) {
    throw UnimplementedError();
  }
}
