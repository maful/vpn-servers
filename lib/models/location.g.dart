// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
    lat: (json['Lat'] as num)?.toDouble(),
    long: (json['Lang'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'Lat': instance.lat,
      'Lang': instance.long,
    };
