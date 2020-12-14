import 'package:json_annotation/json_annotation.dart';
import 'package:vpn_countries/models/location.dart';
import 'package:vpn_countries/models/server.dart';

part 'logical_server.g.dart';

@JsonSerializable()
class LogicalServer {
  LogicalServer({
    this.name,
    this.entryCountry,
    this.exitCountry,
    this.domain,
    this.region,
    this.city,
    this.location,
    this.status,
    this.servers,
    this.load,
    this.score,
  });

  @JsonKey(name: 'Name')
  final String name;
  @JsonKey(name: 'EntryCountry')
  final String entryCountry;
  @JsonKey(name: 'ExitCountry')
  final String exitCountry;
  @JsonKey(name: 'Domain')
  final String domain;
  @JsonKey(name: 'Region')
  final String region;
  @JsonKey(name: 'City')
  final String city;
  @JsonKey(name: 'Location')
  final Location location;
  @JsonKey(name: 'Status')
  final int status;
  @JsonKey(name: 'Servers')
  final List<Server> servers;
  @JsonKey(name: 'Load')
  final int load;
  @JsonKey(name: 'Score')
  final double score;

  String get fullFlagIconUrl {
    var code = entryCountry.toLowerCase();
    // Special condition for United Kingdom flag
    if (code == 'uk') {
      code = 'gb';
    }
    return 'assets/flags/$code.svg';
  }

  factory LogicalServer.fromJson(Map<String, dynamic> json) =>
      _$LogicalServerFromJson(json);

  Map<String, dynamic> toJson() => _$LogicalServerToJson(this);
}
