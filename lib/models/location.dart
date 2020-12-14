import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
  Location({
    this.lat,
    this.long,
  });

  @JsonKey(name: 'Lat')
  final double lat;
  @JsonKey(name: 'Lang')
  final double long;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
