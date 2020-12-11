// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'my_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
MyUser _$MyUserFromJson(Map<String, dynamic> json) {
  return _MyUser.fromJson(json);
}

/// @nodoc
class _$MyUserTearOff {
  const _$MyUserTearOff();

// ignore: unused_element
  _MyUser call(
      {String id,
      @JsonKey(includeIfNull: false) String name,
      String email,
      @JsonKey(includeIfNull: false) String avatar,
      String provider,
      @JsonKey(includeIfNull: false) String tagline,
      @JsonKey(includeIfNull: false, defaultValue: false) bool isVerified,
      String selectedCategory}) {
    return _MyUser(
      id: id,
      name: name,
      email: email,
      avatar: avatar,
      provider: provider,
      tagline: tagline,
      isVerified: isVerified,
      selectedCategory: selectedCategory,
    );
  }

// ignore: unused_element
  MyUser fromJson(Map<String, Object> json) {
    return MyUser.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $MyUser = _$MyUserTearOff();

/// @nodoc
mixin _$MyUser {
  String get id;
  @JsonKey(includeIfNull: false)
  String get name;
  String get email;
  @JsonKey(includeIfNull: false)
  String get avatar;
  String get provider;
  @JsonKey(includeIfNull: false)
  String get tagline;
  @JsonKey(includeIfNull: false, defaultValue: false)
  bool get isVerified;
  String get selectedCategory;

  Map<String, dynamic> toJson();
  $MyUserCopyWith<MyUser> get copyWith;
}

/// @nodoc
abstract class $MyUserCopyWith<$Res> {
  factory $MyUserCopyWith(MyUser value, $Res Function(MyUser) then) =
      _$MyUserCopyWithImpl<$Res>;
  $Res call(
      {String id,
      @JsonKey(includeIfNull: false) String name,
      String email,
      @JsonKey(includeIfNull: false) String avatar,
      String provider,
      @JsonKey(includeIfNull: false) String tagline,
      @JsonKey(includeIfNull: false, defaultValue: false) bool isVerified,
      String selectedCategory});
}

/// @nodoc
class _$MyUserCopyWithImpl<$Res> implements $MyUserCopyWith<$Res> {
  _$MyUserCopyWithImpl(this._value, this._then);

  final MyUser _value;
  // ignore: unused_field
  final $Res Function(MyUser) _then;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object email = freezed,
    Object avatar = freezed,
    Object provider = freezed,
    Object tagline = freezed,
    Object isVerified = freezed,
    Object selectedCategory = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
      email: email == freezed ? _value.email : email as String,
      avatar: avatar == freezed ? _value.avatar : avatar as String,
      provider: provider == freezed ? _value.provider : provider as String,
      tagline: tagline == freezed ? _value.tagline : tagline as String,
      isVerified:
          isVerified == freezed ? _value.isVerified : isVerified as bool,
      selectedCategory: selectedCategory == freezed
          ? _value.selectedCategory
          : selectedCategory as String,
    ));
  }
}

/// @nodoc
abstract class _$MyUserCopyWith<$Res> implements $MyUserCopyWith<$Res> {
  factory _$MyUserCopyWith(_MyUser value, $Res Function(_MyUser) then) =
      __$MyUserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      @JsonKey(includeIfNull: false) String name,
      String email,
      @JsonKey(includeIfNull: false) String avatar,
      String provider,
      @JsonKey(includeIfNull: false) String tagline,
      @JsonKey(includeIfNull: false, defaultValue: false) bool isVerified,
      String selectedCategory});
}

/// @nodoc
class __$MyUserCopyWithImpl<$Res> extends _$MyUserCopyWithImpl<$Res>
    implements _$MyUserCopyWith<$Res> {
  __$MyUserCopyWithImpl(_MyUser _value, $Res Function(_MyUser) _then)
      : super(_value, (v) => _then(v as _MyUser));

  @override
  _MyUser get _value => super._value as _MyUser;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object email = freezed,
    Object avatar = freezed,
    Object provider = freezed,
    Object tagline = freezed,
    Object isVerified = freezed,
    Object selectedCategory = freezed,
  }) {
    return _then(_MyUser(
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
      email: email == freezed ? _value.email : email as String,
      avatar: avatar == freezed ? _value.avatar : avatar as String,
      provider: provider == freezed ? _value.provider : provider as String,
      tagline: tagline == freezed ? _value.tagline : tagline as String,
      isVerified:
          isVerified == freezed ? _value.isVerified : isVerified as bool,
      selectedCategory: selectedCategory == freezed
          ? _value.selectedCategory
          : selectedCategory as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_MyUser implements _MyUser {
  _$_MyUser(
      {this.id,
      @JsonKey(includeIfNull: false) this.name,
      this.email,
      @JsonKey(includeIfNull: false) this.avatar,
      this.provider,
      @JsonKey(includeIfNull: false) this.tagline,
      @JsonKey(includeIfNull: false, defaultValue: false) this.isVerified,
      this.selectedCategory});

  factory _$_MyUser.fromJson(Map<String, dynamic> json) =>
      _$_$_MyUserFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(includeIfNull: false)
  final String name;
  @override
  final String email;
  @override
  @JsonKey(includeIfNull: false)
  final String avatar;
  @override
  final String provider;
  @override
  @JsonKey(includeIfNull: false)
  final String tagline;
  @override
  @JsonKey(includeIfNull: false, defaultValue: false)
  final bool isVerified;
  @override
  final String selectedCategory;

  @override
  String toString() {
    return 'MyUser(id: $id, name: $name, email: $email, avatar: $avatar, provider: $provider, tagline: $tagline, isVerified: $isVerified, selectedCategory: $selectedCategory)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MyUser &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.avatar, avatar) ||
                const DeepCollectionEquality().equals(other.avatar, avatar)) &&
            (identical(other.provider, provider) ||
                const DeepCollectionEquality()
                    .equals(other.provider, provider)) &&
            (identical(other.tagline, tagline) ||
                const DeepCollectionEquality()
                    .equals(other.tagline, tagline)) &&
            (identical(other.isVerified, isVerified) ||
                const DeepCollectionEquality()
                    .equals(other.isVerified, isVerified)) &&
            (identical(other.selectedCategory, selectedCategory) ||
                const DeepCollectionEquality()
                    .equals(other.selectedCategory, selectedCategory)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(avatar) ^
      const DeepCollectionEquality().hash(provider) ^
      const DeepCollectionEquality().hash(tagline) ^
      const DeepCollectionEquality().hash(isVerified) ^
      const DeepCollectionEquality().hash(selectedCategory);

  @override
  _$MyUserCopyWith<_MyUser> get copyWith =>
      __$MyUserCopyWithImpl<_MyUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_MyUserToJson(this);
  }
}

abstract class _MyUser implements MyUser {
  factory _MyUser(
      {String id,
      @JsonKey(includeIfNull: false) String name,
      String email,
      @JsonKey(includeIfNull: false) String avatar,
      String provider,
      @JsonKey(includeIfNull: false) String tagline,
      @JsonKey(includeIfNull: false, defaultValue: false) bool isVerified,
      String selectedCategory}) = _$_MyUser;

  factory _MyUser.fromJson(Map<String, dynamic> json) = _$_MyUser.fromJson;

  @override
  String get id;
  @override
  @JsonKey(includeIfNull: false)
  String get name;
  @override
  String get email;
  @override
  @JsonKey(includeIfNull: false)
  String get avatar;
  @override
  String get provider;
  @override
  @JsonKey(includeIfNull: false)
  String get tagline;
  @override
  @JsonKey(includeIfNull: false, defaultValue: false)
  bool get isVerified;
  @override
  String get selectedCategory;
  @override
  _$MyUserCopyWith<_MyUser> get copyWith;
}
