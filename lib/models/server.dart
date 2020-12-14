import 'package:json_annotation/json_annotation.dart';

part 'server.g.dart';

@JsonSerializable()
class Server {
  Server({
    this.entryIp,
    this.exitIp,
    this.domain,
  });

  @JsonKey(name: 'EntryIP')
  final String entryIp;
  @JsonKey(name: 'ExitIP')
  final String exitIp;
  @JsonKey(name: 'Domain')
  final String domain;

  factory Server.fromJson(Map<String, dynamic> json) => _$ServerFromJson(json);

  Map<String, dynamic> toJson() => _$ServerToJson(this);
}
