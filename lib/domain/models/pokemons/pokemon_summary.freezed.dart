// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pokemon_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PokemonSummary {

 int get id; String get name; List<String> get types; String get imageUrl;
/// Create a copy of PokemonSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PokemonSummaryCopyWith<PokemonSummary> get copyWith => _$PokemonSummaryCopyWithImpl<PokemonSummary>(this as PokemonSummary, _$identity);

  /// Serializes this PokemonSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PokemonSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.types, types)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(types),imageUrl);

@override
String toString() {
  return 'PokemonSummary(id: $id, name: $name, types: $types, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $PokemonSummaryCopyWith<$Res>  {
  factory $PokemonSummaryCopyWith(PokemonSummary value, $Res Function(PokemonSummary) _then) = _$PokemonSummaryCopyWithImpl;
@useResult
$Res call({
 int id, String name, List<String> types, String imageUrl
});




}
/// @nodoc
class _$PokemonSummaryCopyWithImpl<$Res>
    implements $PokemonSummaryCopyWith<$Res> {
  _$PokemonSummaryCopyWithImpl(this._self, this._then);

  final PokemonSummary _self;
  final $Res Function(PokemonSummary) _then;

/// Create a copy of PokemonSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? types = null,Object? imageUrl = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,types: null == types ? _self.types : types // ignore: cast_nullable_to_non_nullable
as List<String>,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PokemonSummary].
extension PokemonSummaryPatterns on PokemonSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PokemonSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PokemonSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PokemonSummary value)  $default,){
final _that = this;
switch (_that) {
case _PokemonSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PokemonSummary value)?  $default,){
final _that = this;
switch (_that) {
case _PokemonSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  List<String> types,  String imageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PokemonSummary() when $default != null:
return $default(_that.id,_that.name,_that.types,_that.imageUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  List<String> types,  String imageUrl)  $default,) {final _that = this;
switch (_that) {
case _PokemonSummary():
return $default(_that.id,_that.name,_that.types,_that.imageUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  List<String> types,  String imageUrl)?  $default,) {final _that = this;
switch (_that) {
case _PokemonSummary() when $default != null:
return $default(_that.id,_that.name,_that.types,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PokemonSummary implements PokemonSummary {
  const _PokemonSummary({required this.id, required this.name, required final  List<String> types, required this.imageUrl}): _types = types;
  factory _PokemonSummary.fromJson(Map<String, dynamic> json) => _$PokemonSummaryFromJson(json);

@override final  int id;
@override final  String name;
 final  List<String> _types;
@override List<String> get types {
  if (_types is EqualUnmodifiableListView) return _types;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_types);
}

@override final  String imageUrl;

/// Create a copy of PokemonSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PokemonSummaryCopyWith<_PokemonSummary> get copyWith => __$PokemonSummaryCopyWithImpl<_PokemonSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PokemonSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PokemonSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._types, _types)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(_types),imageUrl);

@override
String toString() {
  return 'PokemonSummary(id: $id, name: $name, types: $types, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$PokemonSummaryCopyWith<$Res> implements $PokemonSummaryCopyWith<$Res> {
  factory _$PokemonSummaryCopyWith(_PokemonSummary value, $Res Function(_PokemonSummary) _then) = __$PokemonSummaryCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, List<String> types, String imageUrl
});




}
/// @nodoc
class __$PokemonSummaryCopyWithImpl<$Res>
    implements _$PokemonSummaryCopyWith<$Res> {
  __$PokemonSummaryCopyWithImpl(this._self, this._then);

  final _PokemonSummary _self;
  final $Res Function(_PokemonSummary) _then;

/// Create a copy of PokemonSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? types = null,Object? imageUrl = null,}) {
  return _then(_PokemonSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,types: null == types ? _self._types : types // ignore: cast_nullable_to_non_nullable
as List<String>,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
