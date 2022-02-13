// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'inventory.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Inventory _$InventoryFromJson(Map<String, dynamic> json) {
  return _Inventory.fromJson(json);
}

/// @nodoc
class _$InventoryTearOff {
  const _$InventoryTearOff();

  _Inventory call({required String name, required String description}) {
    return _Inventory(
      name: name,
      description: description,
    );
  }

  Inventory fromJson(Map<String, Object?> json) {
    return Inventory.fromJson(json);
  }
}

/// @nodoc
const $Inventory = _$InventoryTearOff();

/// @nodoc
mixin _$Inventory {
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InventoryCopyWith<Inventory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InventoryCopyWith<$Res> {
  factory $InventoryCopyWith(Inventory value, $Res Function(Inventory) then) =
      _$InventoryCopyWithImpl<$Res>;
  $Res call({String name, String description});
}

/// @nodoc
class _$InventoryCopyWithImpl<$Res> implements $InventoryCopyWith<$Res> {
  _$InventoryCopyWithImpl(this._value, this._then);

  final Inventory _value;
  // ignore: unused_field
  final $Res Function(Inventory) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$InventoryCopyWith<$Res> implements $InventoryCopyWith<$Res> {
  factory _$InventoryCopyWith(
          _Inventory value, $Res Function(_Inventory) then) =
      __$InventoryCopyWithImpl<$Res>;
  @override
  $Res call({String name, String description});
}

/// @nodoc
class __$InventoryCopyWithImpl<$Res> extends _$InventoryCopyWithImpl<$Res>
    implements _$InventoryCopyWith<$Res> {
  __$InventoryCopyWithImpl(_Inventory _value, $Res Function(_Inventory) _then)
      : super(_value, (v) => _then(v as _Inventory));

  @override
  _Inventory get _value => super._value as _Inventory;

  @override
  $Res call({
    Object? name = freezed,
    Object? description = freezed,
  }) {
    return _then(_Inventory(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Inventory with DiagnosticableTreeMixin implements _Inventory {
  const _$_Inventory({required this.name, required this.description});

  factory _$_Inventory.fromJson(Map<String, dynamic> json) =>
      _$$_InventoryFromJson(json);

  @override
  final String name;
  @override
  final String description;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Inventory(name: $name, description: $description)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Inventory'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('description', description));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Inventory &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.description, description));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(description));

  @JsonKey(ignore: true)
  @override
  _$InventoryCopyWith<_Inventory> get copyWith =>
      __$InventoryCopyWithImpl<_Inventory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InventoryToJson(this);
  }
}

abstract class _Inventory implements Inventory {
  const factory _Inventory(
      {required String name, required String description}) = _$_Inventory;

  factory _Inventory.fromJson(Map<String, dynamic> json) =
      _$_Inventory.fromJson;

  @override
  String get name;
  @override
  String get description;
  @override
  @JsonKey(ignore: true)
  _$InventoryCopyWith<_Inventory> get copyWith =>
      throw _privateConstructorUsedError;
}
