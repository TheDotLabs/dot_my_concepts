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
      String selectedCategory,
      Teaching teaching}) {
    return _MyUser(
      id: id,
      name: name,
      email: email,
      avatar: avatar,
      provider: provider,
      tagline: tagline,
      isVerified: isVerified,
      selectedCategory: selectedCategory,
      teaching: teaching,
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
  Teaching get teaching;

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
      String selectedCategory,
      Teaching teaching});

  $TeachingCopyWith<$Res> get teaching;
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
    Object teaching = freezed,
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
      teaching: teaching == freezed ? _value.teaching : teaching as Teaching,
    ));
  }

  @override
  $TeachingCopyWith<$Res> get teaching {
    if (_value.teaching == null) {
      return null;
    }
    return $TeachingCopyWith<$Res>(_value.teaching, (value) {
      return _then(_value.copyWith(teaching: value));
    });
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
      String selectedCategory,
      Teaching teaching});

  @override
  $TeachingCopyWith<$Res> get teaching;
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
    Object teaching = freezed,
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
      teaching: teaching == freezed ? _value.teaching : teaching as Teaching,
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
      this.selectedCategory,
      this.teaching});

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
  final Teaching teaching;

  @override
  String toString() {
    return 'MyUser(id: $id, name: $name, email: $email, avatar: $avatar, provider: $provider, tagline: $tagline, isVerified: $isVerified, selectedCategory: $selectedCategory, teaching: $teaching)';
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
                    .equals(other.selectedCategory, selectedCategory)) &&
            (identical(other.teaching, teaching) ||
                const DeepCollectionEquality()
                    .equals(other.teaching, teaching)));
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
      const DeepCollectionEquality().hash(selectedCategory) ^
      const DeepCollectionEquality().hash(teaching);

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
      String selectedCategory,
      Teaching teaching}) = _$_MyUser;

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
  Teaching get teaching;
  @override
  _$MyUserCopyWith<_MyUser> get copyWith;
}

Teaching _$TeachingFromJson(Map<String, dynamic> json) {
  return _Teaching.fromJson(json);
}

/// @nodoc
class _$TeachingTearOff {
  const _$TeachingTearOff();

// ignore: unused_element
  _Teaching call(
      {@JsonKey(defaultValue: false) bool isTeacher,
      @JsonKey(defaultValue: false) bool hasSignedCLA,
      @JsonKey(defaultValue: false) bool isVerified}) {
    return _Teaching(
      isTeacher: isTeacher,
      hasSignedCLA: hasSignedCLA,
      isVerified: isVerified,
    );
  }

// ignore: unused_element
  Teaching fromJson(Map<String, Object> json) {
    return Teaching.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Teaching = _$TeachingTearOff();

/// @nodoc
mixin _$Teaching {
  @JsonKey(defaultValue: false)
  bool get isTeacher;
  @JsonKey(defaultValue: false)
  bool get hasSignedCLA;
  @JsonKey(defaultValue: false)
  bool get isVerified;

  Map<String, dynamic> toJson();
  $TeachingCopyWith<Teaching> get copyWith;
}

/// @nodoc
abstract class $TeachingCopyWith<$Res> {
  factory $TeachingCopyWith(Teaching value, $Res Function(Teaching) then) =
      _$TeachingCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(defaultValue: false) bool isTeacher,
      @JsonKey(defaultValue: false) bool hasSignedCLA,
      @JsonKey(defaultValue: false) bool isVerified});
}

/// @nodoc
class _$TeachingCopyWithImpl<$Res> implements $TeachingCopyWith<$Res> {
  _$TeachingCopyWithImpl(this._value, this._then);

  final Teaching _value;
  // ignore: unused_field
  final $Res Function(Teaching) _then;

  @override
  $Res call({
    Object isTeacher = freezed,
    Object hasSignedCLA = freezed,
    Object isVerified = freezed,
  }) {
    return _then(_value.copyWith(
      isTeacher: isTeacher == freezed ? _value.isTeacher : isTeacher as bool,
      hasSignedCLA:
          hasSignedCLA == freezed ? _value.hasSignedCLA : hasSignedCLA as bool,
      isVerified:
          isVerified == freezed ? _value.isVerified : isVerified as bool,
    ));
  }
}

/// @nodoc
abstract class _$TeachingCopyWith<$Res> implements $TeachingCopyWith<$Res> {
  factory _$TeachingCopyWith(_Teaching value, $Res Function(_Teaching) then) =
      __$TeachingCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(defaultValue: false) bool isTeacher,
      @JsonKey(defaultValue: false) bool hasSignedCLA,
      @JsonKey(defaultValue: false) bool isVerified});
}

/// @nodoc
class __$TeachingCopyWithImpl<$Res> extends _$TeachingCopyWithImpl<$Res>
    implements _$TeachingCopyWith<$Res> {
  __$TeachingCopyWithImpl(_Teaching _value, $Res Function(_Teaching) _then)
      : super(_value, (v) => _then(v as _Teaching));

  @override
  _Teaching get _value => super._value as _Teaching;

  @override
  $Res call({
    Object isTeacher = freezed,
    Object hasSignedCLA = freezed,
    Object isVerified = freezed,
  }) {
    return _then(_Teaching(
      isTeacher: isTeacher == freezed ? _value.isTeacher : isTeacher as bool,
      hasSignedCLA:
          hasSignedCLA == freezed ? _value.hasSignedCLA : hasSignedCLA as bool,
      isVerified:
          isVerified == freezed ? _value.isVerified : isVerified as bool,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Teaching implements _Teaching {
  _$_Teaching(
      {@JsonKey(defaultValue: false) this.isTeacher,
      @JsonKey(defaultValue: false) this.hasSignedCLA,
      @JsonKey(defaultValue: false) this.isVerified});

  factory _$_Teaching.fromJson(Map<String, dynamic> json) =>
      _$_$_TeachingFromJson(json);

  @override
  @JsonKey(defaultValue: false)
  final bool isTeacher;
  @override
  @JsonKey(defaultValue: false)
  final bool hasSignedCLA;
  @override
  @JsonKey(defaultValue: false)
  final bool isVerified;

  @override
  String toString() {
    return 'Teaching(isTeacher: $isTeacher, hasSignedCLA: $hasSignedCLA, isVerified: $isVerified)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Teaching &&
            (identical(other.isTeacher, isTeacher) ||
                const DeepCollectionEquality()
                    .equals(other.isTeacher, isTeacher)) &&
            (identical(other.hasSignedCLA, hasSignedCLA) ||
                const DeepCollectionEquality()
                    .equals(other.hasSignedCLA, hasSignedCLA)) &&
            (identical(other.isVerified, isVerified) ||
                const DeepCollectionEquality()
                    .equals(other.isVerified, isVerified)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(isTeacher) ^
      const DeepCollectionEquality().hash(hasSignedCLA) ^
      const DeepCollectionEquality().hash(isVerified);

  @override
  _$TeachingCopyWith<_Teaching> get copyWith =>
      __$TeachingCopyWithImpl<_Teaching>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_TeachingToJson(this);
  }
}

abstract class _Teaching implements Teaching {
  factory _Teaching(
      {@JsonKey(defaultValue: false) bool isTeacher,
      @JsonKey(defaultValue: false) bool hasSignedCLA,
      @JsonKey(defaultValue: false) bool isVerified}) = _$_Teaching;

  factory _Teaching.fromJson(Map<String, dynamic> json) = _$_Teaching.fromJson;

  @override
  @JsonKey(defaultValue: false)
  bool get isTeacher;
  @override
  @JsonKey(defaultValue: false)
  bool get hasSignedCLA;
  @override
  @JsonKey(defaultValue: false)
  bool get isVerified;
  @override
  _$TeachingCopyWith<_Teaching> get copyWith;
}
