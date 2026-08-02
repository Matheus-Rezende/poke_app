// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'region_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegionSummary {

 String get generationName; String get regionName;
/// Create a copy of RegionSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegionSummaryCopyWith<RegionSummary> get copyWith => _$RegionSummaryCopyWithImpl<RegionSummary>(this as RegionSummary, _$identity);

  /// Serializes this RegionSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegionSummary&&(identical(other.generationName, generationName) || other.generationName == generationName)&&(identical(other.regionName, regionName) || other.regionName == regionName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,generationName,regionName);

@override
String toString() {
  return 'RegionSummary(generationName: $generationName, regionName: $regionName)';
}


}

/// @nodoc
abstract mixin class $RegionSummaryCopyWith<$Res>  {
  factory $RegionSummaryCopyWith(RegionSummary value, $Res Function(RegionSummary) _then) = _$RegionSummaryCopyWithImpl;
@useResult
$Res call({
 String generationName, String regionName
});




}
/// @nodoc
class _$RegionSummaryCopyWithImpl<$Res>
    implements $RegionSummaryCopyWith<$Res> {
  _$RegionSummaryCopyWithImpl(this._self, this._then);

  final RegionSummary _self;
  final $Res Function(RegionSummary) _then;

/// Create a copy of RegionSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? generationName = null,Object? regionName = null,}) {
  return _then(_self.copyWith(
generationName: null == generationName ? _self.generationName : generationName // ignore: cast_nullable_to_non_nullable
as String,regionName: null == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RegionSummary].
extension RegionSummaryPatterns on RegionSummary {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegionSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegionSummary() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegionSummary value)  $default,){
final _that = this;
switch (_that) {
case _RegionSummary():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegionSummary value)?  $default,){
final _that = this;
switch (_that) {
case _RegionSummary() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String generationName,  String regionName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegionSummary() when $default != null:
return $default(_that.generationName,_that.regionName);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String generationName,  String regionName)  $default,) {final _that = this;
switch (_that) {
case _RegionSummary():
return $default(_that.generationName,_that.regionName);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String generationName,  String regionName)?  $default,) {final _that = this;
switch (_that) {
case _RegionSummary() when $default != null:
return $default(_that.generationName,_that.regionName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegionSummary implements RegionSummary {
  const _RegionSummary({required this.generationName, required this.regionName});
  factory _RegionSummary.fromJson(Map<String, dynamic> json) => _$RegionSummaryFromJson(json);

@override final  String generationName;
@override final  String regionName;

/// Create a copy of RegionSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegionSummaryCopyWith<_RegionSummary> get copyWith => __$RegionSummaryCopyWithImpl<_RegionSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegionSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegionSummary&&(identical(other.generationName, generationName) || other.generationName == generationName)&&(identical(other.regionName, regionName) || other.regionName == regionName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,generationName,regionName);

@override
String toString() {
  return 'RegionSummary(generationName: $generationName, regionName: $regionName)';
}


}

/// @nodoc
abstract mixin class _$RegionSummaryCopyWith<$Res> implements $RegionSummaryCopyWith<$Res> {
  factory _$RegionSummaryCopyWith(_RegionSummary value, $Res Function(_RegionSummary) _then) = __$RegionSummaryCopyWithImpl;
@override @useResult
$Res call({
 String generationName, String regionName
});




}
/// @nodoc
class __$RegionSummaryCopyWithImpl<$Res>
    implements _$RegionSummaryCopyWith<$Res> {
  __$RegionSummaryCopyWithImpl(this._self, this._then);

  final _RegionSummary _self;
  final $Res Function(_RegionSummary) _then;

/// Create a copy of RegionSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? generationName = null,Object? regionName = null,}) {
  return _then(_RegionSummary(
generationName: null == generationName ? _self.generationName : generationName // ignore: cast_nullable_to_non_nullable
as String,regionName: null == regionName ? _self.regionName : regionName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
