import 'package:flutter/foundation.dart';
import 'package:vpn_countries/models/logical_server.dart';

class CountryServer {
  CountryServer({
    @required this.code,
    @required this.logicalServers,
  });

  final String code;
  final List<LogicalServer> logicalServers;
}
