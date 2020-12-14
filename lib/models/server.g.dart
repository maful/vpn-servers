// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Server _$ServerFromJson(Map<String, dynamic> json) {
  return Server(
    entryIp: json['EntryIP'] as String,
    exitIp: json['ExitIP'] as String,
    domain: json['Domain'] as String,
  );
}

Map<String, dynamic> _$ServerToJson(Server instance) => <String, dynamic>{
      'EntryIP': instance.entryIp,
      'ExitIP': instance.exitIp,
      'Domain': instance.domain,
    };
