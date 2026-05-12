// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_station.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WeatherStation {
  String get cityName => throw _privateConstructorUsedError;
  String get weather => throw _privateConstructorUsedError;
  String? get temperature => throw _privateConstructorUsedError;
  String? get humidity => throw _privateConstructorUsedError;
  String? get windSpeed =>
      throw _privateConstructorUsedError; // 氣象站緯度（GeoInfo.Coordinates）
  double? get latitude =>
      throw _privateConstructorUsedError; // 氣象站經度（GeoInfo.Coordinates）
  double? get longitude => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WeatherStationCopyWith<WeatherStation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherStationCopyWith<$Res> {
  factory $WeatherStationCopyWith(
          WeatherStation value, $Res Function(WeatherStation) then) =
      _$WeatherStationCopyWithImpl<$Res, WeatherStation>;
  @useResult
  $Res call(
      {String cityName,
      String weather,
      String? temperature,
      String? humidity,
      String? windSpeed,
      double? latitude,
      double? longitude});
}

/// @nodoc
class _$WeatherStationCopyWithImpl<$Res, $Val extends WeatherStation>
    implements $WeatherStationCopyWith<$Res> {
  _$WeatherStationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cityName = null,
    Object? weather = null,
    Object? temperature = freezed,
    Object? humidity = freezed,
    Object? windSpeed = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(_value.copyWith(
      cityName: null == cityName
          ? _value.cityName
          : cityName // ignore: cast_nullable_to_non_nullable
              as String,
      weather: null == weather
          ? _value.weather
          : weather // ignore: cast_nullable_to_non_nullable
              as String,
      temperature: freezed == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as String?,
      humidity: freezed == humidity
          ? _value.humidity
          : humidity // ignore: cast_nullable_to_non_nullable
              as String?,
      windSpeed: freezed == windSpeed
          ? _value.windSpeed
          : windSpeed // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WeatherStationImplCopyWith<$Res>
    implements $WeatherStationCopyWith<$Res> {
  factory _$$WeatherStationImplCopyWith(_$WeatherStationImpl value,
          $Res Function(_$WeatherStationImpl) then) =
      __$$WeatherStationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String cityName,
      String weather,
      String? temperature,
      String? humidity,
      String? windSpeed,
      double? latitude,
      double? longitude});
}

/// @nodoc
class __$$WeatherStationImplCopyWithImpl<$Res>
    extends _$WeatherStationCopyWithImpl<$Res, _$WeatherStationImpl>
    implements _$$WeatherStationImplCopyWith<$Res> {
  __$$WeatherStationImplCopyWithImpl(
      _$WeatherStationImpl _value, $Res Function(_$WeatherStationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cityName = null,
    Object? weather = null,
    Object? temperature = freezed,
    Object? humidity = freezed,
    Object? windSpeed = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(_$WeatherStationImpl(
      cityName: null == cityName
          ? _value.cityName
          : cityName // ignore: cast_nullable_to_non_nullable
              as String,
      weather: null == weather
          ? _value.weather
          : weather // ignore: cast_nullable_to_non_nullable
              as String,
      temperature: freezed == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as String?,
      humidity: freezed == humidity
          ? _value.humidity
          : humidity // ignore: cast_nullable_to_non_nullable
              as String?,
      windSpeed: freezed == windSpeed
          ? _value.windSpeed
          : windSpeed // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class _$WeatherStationImpl implements _WeatherStation {
  const _$WeatherStationImpl(
      {required this.cityName,
      required this.weather,
      this.temperature,
      this.humidity,
      this.windSpeed,
      this.latitude,
      this.longitude});

  @override
  final String cityName;
  @override
  final String weather;
  @override
  final String? temperature;
  @override
  final String? humidity;
  @override
  final String? windSpeed;
// 氣象站緯度（GeoInfo.Coordinates）
  @override
  final double? latitude;
// 氣象站經度（GeoInfo.Coordinates）
  @override
  final double? longitude;

  @override
  String toString() {
    return 'WeatherStation(cityName: $cityName, weather: $weather, temperature: $temperature, humidity: $humidity, windSpeed: $windSpeed, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeatherStationImpl &&
            (identical(other.cityName, cityName) ||
                other.cityName == cityName) &&
            (identical(other.weather, weather) || other.weather == weather) &&
            (identical(other.temperature, temperature) ||
                other.temperature == temperature) &&
            (identical(other.humidity, humidity) ||
                other.humidity == humidity) &&
            (identical(other.windSpeed, windSpeed) ||
                other.windSpeed == windSpeed) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @override
  int get hashCode => Object.hash(runtimeType, cityName, weather, temperature,
      humidity, windSpeed, latitude, longitude);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WeatherStationImplCopyWith<_$WeatherStationImpl> get copyWith =>
      __$$WeatherStationImplCopyWithImpl<_$WeatherStationImpl>(
          this, _$identity);
}

abstract class _WeatherStation implements WeatherStation {
  const factory _WeatherStation(
      {required final String cityName,
      required final String weather,
      final String? temperature,
      final String? humidity,
      final String? windSpeed,
      final double? latitude,
      final double? longitude}) = _$WeatherStationImpl;

  @override
  String get cityName;
  @override
  String get weather;
  @override
  String? get temperature;
  @override
  String? get humidity;
  @override
  String? get windSpeed;
  @override // 氣象站緯度（GeoInfo.Coordinates）
  double? get latitude;
  @override // 氣象站經度（GeoInfo.Coordinates）
  double? get longitude;
  @override
  @JsonKey(ignore: true)
  _$$WeatherStationImplCopyWith<_$WeatherStationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WeatherStationResponse _$WeatherStationResponseFromJson(
    Map<String, dynamic> json) {
  return _WeatherStationResponse.fromJson(json);
}

/// @nodoc
mixin _$WeatherStationResponse {
  bool get success => throw _privateConstructorUsedError;
  Records get records => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeatherStationResponseCopyWith<WeatherStationResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherStationResponseCopyWith<$Res> {
  factory $WeatherStationResponseCopyWith(WeatherStationResponse value,
          $Res Function(WeatherStationResponse) then) =
      _$WeatherStationResponseCopyWithImpl<$Res, WeatherStationResponse>;
  @useResult
  $Res call({bool success, Records records});

  $RecordsCopyWith<$Res> get records;
}

/// @nodoc
class _$WeatherStationResponseCopyWithImpl<$Res,
        $Val extends WeatherStationResponse>
    implements $WeatherStationResponseCopyWith<$Res> {
  _$WeatherStationResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? records = null,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      records: null == records
          ? _value.records
          : records // ignore: cast_nullable_to_non_nullable
              as Records,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RecordsCopyWith<$Res> get records {
    return $RecordsCopyWith<$Res>(_value.records, (value) {
      return _then(_value.copyWith(records: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WeatherStationResponseImplCopyWith<$Res>
    implements $WeatherStationResponseCopyWith<$Res> {
  factory _$$WeatherStationResponseImplCopyWith(
          _$WeatherStationResponseImpl value,
          $Res Function(_$WeatherStationResponseImpl) then) =
      __$$WeatherStationResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, Records records});

  @override
  $RecordsCopyWith<$Res> get records;
}

/// @nodoc
class __$$WeatherStationResponseImplCopyWithImpl<$Res>
    extends _$WeatherStationResponseCopyWithImpl<$Res,
        _$WeatherStationResponseImpl>
    implements _$$WeatherStationResponseImplCopyWith<$Res> {
  __$$WeatherStationResponseImplCopyWithImpl(
      _$WeatherStationResponseImpl _value,
      $Res Function(_$WeatherStationResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? records = null,
  }) {
    return _then(_$WeatherStationResponseImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      records: null == records
          ? _value.records
          : records // ignore: cast_nullable_to_non_nullable
              as Records,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WeatherStationResponseImpl implements _WeatherStationResponse {
  const _$WeatherStationResponseImpl(
      {required this.success, required this.records});

  factory _$WeatherStationResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeatherStationResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final Records records;

  @override
  String toString() {
    return 'WeatherStationResponse(success: $success, records: $records)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeatherStationResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.records, records) || other.records == records));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, success, records);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WeatherStationResponseImplCopyWith<_$WeatherStationResponseImpl>
      get copyWith => __$$WeatherStationResponseImplCopyWithImpl<
          _$WeatherStationResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeatherStationResponseImplToJson(
      this,
    );
  }
}

abstract class _WeatherStationResponse implements WeatherStationResponse {
  const factory _WeatherStationResponse(
      {required final bool success,
      required final Records records}) = _$WeatherStationResponseImpl;

  factory _WeatherStationResponse.fromJson(Map<String, dynamic> json) =
      _$WeatherStationResponseImpl.fromJson;

  @override
  bool get success;
  @override
  Records get records;
  @override
  @JsonKey(ignore: true)
  _$$WeatherStationResponseImplCopyWith<_$WeatherStationResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

Records _$RecordsFromJson(Map<String, dynamic> json) {
  return _Records.fromJson(json);
}

/// @nodoc
mixin _$Records {
  List<Map<String, dynamic>> get station => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecordsCopyWith<Records> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordsCopyWith<$Res> {
  factory $RecordsCopyWith(Records value, $Res Function(Records) then) =
      _$RecordsCopyWithImpl<$Res, Records>;
  @useResult
  $Res call({List<Map<String, dynamic>> station});
}

/// @nodoc
class _$RecordsCopyWithImpl<$Res, $Val extends Records>
    implements $RecordsCopyWith<$Res> {
  _$RecordsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? station = null,
  }) {
    return _then(_value.copyWith(
      station: null == station
          ? _value.station
          : station // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecordsImplCopyWith<$Res> implements $RecordsCopyWith<$Res> {
  factory _$$RecordsImplCopyWith(
          _$RecordsImpl value, $Res Function(_$RecordsImpl) then) =
      __$$RecordsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Map<String, dynamic>> station});
}

/// @nodoc
class __$$RecordsImplCopyWithImpl<$Res>
    extends _$RecordsCopyWithImpl<$Res, _$RecordsImpl>
    implements _$$RecordsImplCopyWith<$Res> {
  __$$RecordsImplCopyWithImpl(
      _$RecordsImpl _value, $Res Function(_$RecordsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? station = null,
  }) {
    return _then(_$RecordsImpl(
      station: null == station
          ? _value._station
          : station // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecordsImpl implements _Records {
  const _$RecordsImpl({required final List<Map<String, dynamic>> station})
      : _station = station;

  factory _$RecordsImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecordsImplFromJson(json);

  final List<Map<String, dynamic>> _station;
  @override
  List<Map<String, dynamic>> get station {
    if (_station is EqualUnmodifiableListView) return _station;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_station);
  }

  @override
  String toString() {
    return 'Records(station: $station)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecordsImpl &&
            const DeepCollectionEquality().equals(other._station, _station));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_station));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecordsImplCopyWith<_$RecordsImpl> get copyWith =>
      __$$RecordsImplCopyWithImpl<_$RecordsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecordsImplToJson(
      this,
    );
  }
}

abstract class _Records implements Records {
  const factory _Records({required final List<Map<String, dynamic>> station}) =
      _$RecordsImpl;

  factory _Records.fromJson(Map<String, dynamic> json) = _$RecordsImpl.fromJson;

  @override
  List<Map<String, dynamic>> get station;
  @override
  @JsonKey(ignore: true)
  _$$RecordsImplCopyWith<_$RecordsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
