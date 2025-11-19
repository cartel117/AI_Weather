// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WeatherState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get hasError => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  WeatherStation? get kaohsiungWeather => throw _privateConstructorUsedError;
  List<WeatherStation> get allCities => throw _privateConstructorUsedError;
  String? get currentTemperature => throw _privateConstructorUsedError;
  String? get humidity => throw _privateConstructorUsedError;
  String? get weatherDescription => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WeatherStateCopyWith<WeatherState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherStateCopyWith<$Res> {
  factory $WeatherStateCopyWith(
          WeatherState value, $Res Function(WeatherState) then) =
      _$WeatherStateCopyWithImpl<$Res, WeatherState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool hasError,
      String? errorMessage,
      WeatherStation? kaohsiungWeather,
      List<WeatherStation> allCities,
      String? currentTemperature,
      String? humidity,
      String? weatherDescription});

  $WeatherStationCopyWith<$Res>? get kaohsiungWeather;
}

/// @nodoc
class _$WeatherStateCopyWithImpl<$Res, $Val extends WeatherState>
    implements $WeatherStateCopyWith<$Res> {
  _$WeatherStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? hasError = null,
    Object? errorMessage = freezed,
    Object? kaohsiungWeather = freezed,
    Object? allCities = null,
    Object? currentTemperature = freezed,
    Object? humidity = freezed,
    Object? weatherDescription = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      hasError: null == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      kaohsiungWeather: freezed == kaohsiungWeather
          ? _value.kaohsiungWeather
          : kaohsiungWeather // ignore: cast_nullable_to_non_nullable
              as WeatherStation?,
      allCities: null == allCities
          ? _value.allCities
          : allCities // ignore: cast_nullable_to_non_nullable
              as List<WeatherStation>,
      currentTemperature: freezed == currentTemperature
          ? _value.currentTemperature
          : currentTemperature // ignore: cast_nullable_to_non_nullable
              as String?,
      humidity: freezed == humidity
          ? _value.humidity
          : humidity // ignore: cast_nullable_to_non_nullable
              as String?,
      weatherDescription: freezed == weatherDescription
          ? _value.weatherDescription
          : weatherDescription // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $WeatherStationCopyWith<$Res>? get kaohsiungWeather {
    if (_value.kaohsiungWeather == null) {
      return null;
    }

    return $WeatherStationCopyWith<$Res>(_value.kaohsiungWeather!, (value) {
      return _then(_value.copyWith(kaohsiungWeather: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WeatherStateImplCopyWith<$Res>
    implements $WeatherStateCopyWith<$Res> {
  factory _$$WeatherStateImplCopyWith(
          _$WeatherStateImpl value, $Res Function(_$WeatherStateImpl) then) =
      __$$WeatherStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool hasError,
      String? errorMessage,
      WeatherStation? kaohsiungWeather,
      List<WeatherStation> allCities,
      String? currentTemperature,
      String? humidity,
      String? weatherDescription});

  @override
  $WeatherStationCopyWith<$Res>? get kaohsiungWeather;
}

/// @nodoc
class __$$WeatherStateImplCopyWithImpl<$Res>
    extends _$WeatherStateCopyWithImpl<$Res, _$WeatherStateImpl>
    implements _$$WeatherStateImplCopyWith<$Res> {
  __$$WeatherStateImplCopyWithImpl(
      _$WeatherStateImpl _value, $Res Function(_$WeatherStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? hasError = null,
    Object? errorMessage = freezed,
    Object? kaohsiungWeather = freezed,
    Object? allCities = null,
    Object? currentTemperature = freezed,
    Object? humidity = freezed,
    Object? weatherDescription = freezed,
  }) {
    return _then(_$WeatherStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      hasError: null == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      kaohsiungWeather: freezed == kaohsiungWeather
          ? _value.kaohsiungWeather
          : kaohsiungWeather // ignore: cast_nullable_to_non_nullable
              as WeatherStation?,
      allCities: null == allCities
          ? _value._allCities
          : allCities // ignore: cast_nullable_to_non_nullable
              as List<WeatherStation>,
      currentTemperature: freezed == currentTemperature
          ? _value.currentTemperature
          : currentTemperature // ignore: cast_nullable_to_non_nullable
              as String?,
      humidity: freezed == humidity
          ? _value.humidity
          : humidity // ignore: cast_nullable_to_non_nullable
              as String?,
      weatherDescription: freezed == weatherDescription
          ? _value.weatherDescription
          : weatherDescription // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$WeatherStateImpl implements _WeatherState {
  const _$WeatherStateImpl(
      {this.isLoading = false,
      this.hasError = false,
      this.errorMessage,
      this.kaohsiungWeather,
      final List<WeatherStation> allCities = const [],
      this.currentTemperature,
      this.humidity,
      this.weatherDescription})
      : _allCities = allCities;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool hasError;
  @override
  final String? errorMessage;
  @override
  final WeatherStation? kaohsiungWeather;
  final List<WeatherStation> _allCities;
  @override
  @JsonKey()
  List<WeatherStation> get allCities {
    if (_allCities is EqualUnmodifiableListView) return _allCities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allCities);
  }

  @override
  final String? currentTemperature;
  @override
  final String? humidity;
  @override
  final String? weatherDescription;

  @override
  String toString() {
    return 'WeatherState(isLoading: $isLoading, hasError: $hasError, errorMessage: $errorMessage, kaohsiungWeather: $kaohsiungWeather, allCities: $allCities, currentTemperature: $currentTemperature, humidity: $humidity, weatherDescription: $weatherDescription)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeatherStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.hasError, hasError) ||
                other.hasError == hasError) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.kaohsiungWeather, kaohsiungWeather) ||
                other.kaohsiungWeather == kaohsiungWeather) &&
            const DeepCollectionEquality()
                .equals(other._allCities, _allCities) &&
            (identical(other.currentTemperature, currentTemperature) ||
                other.currentTemperature == currentTemperature) &&
            (identical(other.humidity, humidity) ||
                other.humidity == humidity) &&
            (identical(other.weatherDescription, weatherDescription) ||
                other.weatherDescription == weatherDescription));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      hasError,
      errorMessage,
      kaohsiungWeather,
      const DeepCollectionEquality().hash(_allCities),
      currentTemperature,
      humidity,
      weatherDescription);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WeatherStateImplCopyWith<_$WeatherStateImpl> get copyWith =>
      __$$WeatherStateImplCopyWithImpl<_$WeatherStateImpl>(this, _$identity);
}

abstract class _WeatherState implements WeatherState {
  const factory _WeatherState(
      {final bool isLoading,
      final bool hasError,
      final String? errorMessage,
      final WeatherStation? kaohsiungWeather,
      final List<WeatherStation> allCities,
      final String? currentTemperature,
      final String? humidity,
      final String? weatherDescription}) = _$WeatherStateImpl;

  @override
  bool get isLoading;
  @override
  bool get hasError;
  @override
  String? get errorMessage;
  @override
  WeatherStation? get kaohsiungWeather;
  @override
  List<WeatherStation> get allCities;
  @override
  String? get currentTemperature;
  @override
  String? get humidity;
  @override
  String? get weatherDescription;
  @override
  @JsonKey(ignore: true)
  _$$WeatherStateImplCopyWith<_$WeatherStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
