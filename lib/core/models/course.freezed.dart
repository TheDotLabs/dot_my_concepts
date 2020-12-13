// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'course.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Course _$CourseFromJson(Map<String, dynamic> json) {
  return _Course.fromJson(json);
}

/// @nodoc
class _$CourseTearOff {
  const _$CourseTearOff();

// ignore: unused_element
  _Course call(
      {String id,
      String userId,
      String title,
      String subtitle,
      String cover,
      List<String> lessons}) {
    return _Course(
      id: id,
      userId: userId,
      title: title,
      subtitle: subtitle,
      cover: cover,
      lessons: lessons,
    );
  }

// ignore: unused_element
  Course fromJson(Map<String, Object> json) {
    return Course.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Course = _$CourseTearOff();

/// @nodoc
mixin _$Course {
  String get id;
  String get userId;
  String get title;
  String get subtitle;
  String get cover;
  List<String> get lessons;

  Map<String, dynamic> toJson();
  $CourseCopyWith<Course> get copyWith;
}

/// @nodoc
abstract class $CourseCopyWith<$Res> {
  factory $CourseCopyWith(Course value, $Res Function(Course) then) =
      _$CourseCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String userId,
      String title,
      String subtitle,
      String cover,
      List<String> lessons});
}

/// @nodoc
class _$CourseCopyWithImpl<$Res> implements $CourseCopyWith<$Res> {
  _$CourseCopyWithImpl(this._value, this._then);

  final Course _value;
  // ignore: unused_field
  final $Res Function(Course) _then;

  @override
  $Res call({
    Object id = freezed,
    Object userId = freezed,
    Object title = freezed,
    Object subtitle = freezed,
    Object cover = freezed,
    Object lessons = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      userId: userId == freezed ? _value.userId : userId as String,
      title: title == freezed ? _value.title : title as String,
      subtitle: subtitle == freezed ? _value.subtitle : subtitle as String,
      cover: cover == freezed ? _value.cover : cover as String,
      lessons: lessons == freezed ? _value.lessons : lessons as List<String>,
    ));
  }
}

/// @nodoc
abstract class _$CourseCopyWith<$Res> implements $CourseCopyWith<$Res> {
  factory _$CourseCopyWith(_Course value, $Res Function(_Course) then) =
      __$CourseCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String userId,
      String title,
      String subtitle,
      String cover,
      List<String> lessons});
}

/// @nodoc
class __$CourseCopyWithImpl<$Res> extends _$CourseCopyWithImpl<$Res>
    implements _$CourseCopyWith<$Res> {
  __$CourseCopyWithImpl(_Course _value, $Res Function(_Course) _then)
      : super(_value, (v) => _then(v as _Course));

  @override
  _Course get _value => super._value as _Course;

  @override
  $Res call({
    Object id = freezed,
    Object userId = freezed,
    Object title = freezed,
    Object subtitle = freezed,
    Object cover = freezed,
    Object lessons = freezed,
  }) {
    return _then(_Course(
      id: id == freezed ? _value.id : id as String,
      userId: userId == freezed ? _value.userId : userId as String,
      title: title == freezed ? _value.title : title as String,
      subtitle: subtitle == freezed ? _value.subtitle : subtitle as String,
      cover: cover == freezed ? _value.cover : cover as String,
      lessons: lessons == freezed ? _value.lessons : lessons as List<String>,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Course implements _Course {
  _$_Course(
      {this.id,
      this.userId,
      this.title,
      this.subtitle,
      this.cover,
      this.lessons});

  factory _$_Course.fromJson(Map<String, dynamic> json) =>
      _$_$_CourseFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String title;
  @override
  final String subtitle;
  @override
  final String cover;
  @override
  final List<String> lessons;

  @override
  String toString() {
    return 'Course(id: $id, userId: $userId, title: $title, subtitle: $subtitle, cover: $cover, lessons: $lessons)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Course &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.subtitle, subtitle) ||
                const DeepCollectionEquality()
                    .equals(other.subtitle, subtitle)) &&
            (identical(other.cover, cover) ||
                const DeepCollectionEquality().equals(other.cover, cover)) &&
            (identical(other.lessons, lessons) ||
                const DeepCollectionEquality().equals(other.lessons, lessons)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(subtitle) ^
      const DeepCollectionEquality().hash(cover) ^
      const DeepCollectionEquality().hash(lessons);

  @override
  _$CourseCopyWith<_Course> get copyWith =>
      __$CourseCopyWithImpl<_Course>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CourseToJson(this);
  }
}

abstract class _Course implements Course {
  factory _Course(
      {String id,
      String userId,
      String title,
      String subtitle,
      String cover,
      List<String> lessons}) = _$_Course;

  factory _Course.fromJson(Map<String, dynamic> json) = _$_Course.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get title;
  @override
  String get subtitle;
  @override
  String get cover;
  @override
  List<String> get lessons;
  @override
  _$CourseCopyWith<_Course> get copyWith;
}
