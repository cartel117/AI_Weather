// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeatherStationResponseImpl _$$WeatherStationResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$WeatherStationResponseImpl(
      success: json['success'] as bool,
      records: Records.fromJson(json['records'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$WeatherStationResponseImplToJson(
        _$WeatherStationResponseImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'records': instance.records,
    };

_$RecordsImpl _$$RecordsImplFromJson(Map<String, dynamic> json) =>
    _$RecordsImpl(
      station: (json['station'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$$RecordsImplToJson(_$RecordsImpl instance) =>
    <String, dynamic>{
      'station': instance.station,
    };
