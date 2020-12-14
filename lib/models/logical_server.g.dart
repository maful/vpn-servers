// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logical_server.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogicalServer _$LogicalServerFromJson(Map<String, dynamic> json) {
  return LogicalServer(
    name: json['Name'] as String,
    entryCountry: json['EntryCountry'] as String,
    exitCountry: json['ExitCountry'] as String,
    domain: json['Domain'] as String,
    region: json['Region'] as String,
    city: json['City'] as String,
    location: json['Location'] == null
        ? null
        : Location.fromJson(json['Location'] as Map<String, dynamic>),
    status: json['Status'] as int,
    servers: (json['Servers'] as List)
        ?.map((e) =>
            e == null ? null : Server.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    load: json['Load'] as int,
    score: (json['Score'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$LogicalServerToJson(LogicalServer instance) =>
    <String, dynamic>{
      'Name': instance.name,
      'EntryCountry': instance.entryCountry,
      'ExitCountry': instance.exitCountry,
      'Domain': instance.domain,
      'Region': instance.region,
      'City': instance.city,
      'Location': instance.location,
      'Status': instance.status,
      'Servers': instance.servers,
      'Load': instance.load,
      'Score': instance.score,
    };
