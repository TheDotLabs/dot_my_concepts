// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'course.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
MyCourse _$MyCourseFromJson(Map<String, dynamic> json) {
  return _MyCourse.fromJson(json);
}

/// @nodoc
class _$MyCourseTearOff {
  const _$MyCourseTearOff();

// ignore: unused_element
  _MyCourse call(
      {String id,
      String userId,
      String title,
      String subtitle,
      String cover,
      String categoryId,
      String subjectId,
      String chapterId,
      String unitId,
      List<String> lessons}) {
    return _MyCourse(
      id: id,
      userId: userId,
      title: title,
      subtitle: subtitle,
      cover: cover,
      categoryId: categoryId,
      subjectId: subjectId,
      chapterId: chapterId,
      unitId: unitId,
      lessons: lessons,
    );
  }

// ignore: unused_element
  MyCourse fromJson(Map<String, Object> json) {
    return MyCourse.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $MyCourse = _$MyCourseTearOff();

/// @nodoc
mixin _$MyCourse {
  String get id;
  String get userId;
  String get title;
  String get subtitle;
  String get cover;
  String get categoryId;
  String get subjectId;
  String get chapterId;
  String get unitId;
  List<String> get lessons;

  Map<String, dynamic> toJson();
  $MyCourseCopyWith<MyCourse> get copyWith;
}

/// @nodoc
abstract class $MyCourseCopyWith<$Res> {
  factory $MyCourseCopyWith(MyCourse value, $Res Function(MyCourse) then) =
      _$MyCourseCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String userId,
      String title,
      String subtitle,
      String cover,
      String categoryId,
      String subjectId,
      String chapterId,
      String unitId,
      List<String> lessons});
}

/// @nodoc
class _$MyCourseCopyWithImpl<$Res> implements $MyCourseCopyWith<$Res> {
  _$MyCourseCopyWithImpl(this._value, this._then);

  final MyCourse _value;
  // ignore: unused_field
  final $Res Function(MyCourse) _then;

  @override
  $Res call({
    Object id = freezed,
    Object userId = freezed,
    Object title = freezed,
    Object subtitle = freezed,
    Object cover = freezed,
    Object categoryId = freezed,
    Object subjectId = freezed,
    Object chapterId = freezed,
    Object unitId = freezed,
    Object lessons = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      userId: userId == freezed ? _value.userId : userId as String,
      title: title == freezed ? _value.title : title as String,
      subtitle: subtitle == freezed ? _value.subtitle : subtitle as String,
      cover: cover == freezed ? _value.cover : cover as String,
      categoryId:
          categoryId == freezed ? _value.categoryId : categoryId as String,
      subjectId: subjectId == freezed ? _value.subjectId : subjectId as String,
      chapterId: chapterId == freezed ? _value.chapterId : chapterId as String,
      unitId: unitId == freezed ? _value.unitId : unitId as String,
      lessons: lessons == freezed ? _value.lessons : lessons as List<String>,
    ));
  }
}

/// @nodoc
abstract class _$MyCourseCopyWith<$Res> implements $MyCourseCopyWith<$Res> {
  factory _$MyCourseCopyWith(_MyCourse value, $Res Function(_MyCourse) then) =
      __$MyCourseCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String userId,
      String title,
      String subtitle,
      String cover,
      String categoryId,
      String subjectId,
      String chapterId,
      String unitId,
      List<String> lessons});
}

/// @nodoc
class __$MyCourseCopyWithImpl<$Res> extends _$MyCourseCopyWithImpl<$Res>
    implements _$MyCourseCopyWith<$Res> {
  __$MyCourseCopyWithImpl(_MyCourse _value, $Res Function(_MyCourse) _then)
      : super(_value, (v) => _then(v as _MyCourse));

  @override
  _MyCourse get _value => super._value as _MyCourse;

  @override
  $Res call({
    Object id = freezed,
    Object userId = freezed,
    Object title = freezed,
    Object subtitle = freezed,
    Object cover = freezed,
    Object categoryId = freezed,
    Object subjectId = freezed,
    Object chapterId = freezed,
    Object unitId = freezed,
    Object lessons = freezed,
  }) {
    return _then(_MyCourse(
      id: id == freezed ? _value.id : id as String,
      userId: userId == freezed ? _value.userId : userId as String,
      title: title == freezed ? _value.title : title as String,
      subtitle: subtitle == freezed ? _value.subtitle : subtitle as String,
      cover: cover == freezed ? _value.cover : cover as String,
      categoryId:
          categoryId == freezed ? _value.categoryId : categoryId as String,
      subjectId: subjectId == freezed ? _value.subjectId : subjectId as String,
      chapterId: chapterId == freezed ? _value.chapterId : chapterId as String,
      unitId: unitId == freezed ? _value.unitId : unitId as String,
      lessons: lessons == freezed ? _value.lessons : lessons as List<String>,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_MyCourse implements _MyCourse {
  _$_MyCourse(
      {this.id,
      this.userId,
      this.title,
      this.subtitle,
      this.cover,
      this.categoryId,
      this.subjectId,
      this.chapterId,
      this.unitId,
      this.lessons});

  factory _$_MyCourse.fromJson(Map<String, dynamic> json) =>
      _$_$_MyCourseFromJson(json);

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
  final String categoryId;
  @override
  final String subjectId;
  @override
  final String chapterId;
  @override
  final String unitId;
  @override
  final List<String> lessons;

  @override
  String toString() {
    return 'MyCourse(id: $id, userId: $userId, title: $title, subtitle: $subtitle, cover: $cover, categoryId: $categoryId, subjectId: $subjectId, chapterId: $chapterId, unitId: $unitId, lessons: $lessons)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MyCourse &&
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
            (identical(other.categoryId, categoryId) ||
                const DeepCollectionEquality()
                    .equals(other.categoryId, categoryId)) &&
            (identical(other.subjectId, subjectId) ||
                const DeepCollectionEquality()
                    .equals(other.subjectId, subjectId)) &&
            (identical(other.chapterId, chapterId) ||
                const DeepCollectionEquality()
                    .equals(other.chapterId, chapterId)) &&
            (identical(other.unitId, unitId) ||
                const DeepCollectionEquality().equals(other.unitId, unitId)) &&
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
      const DeepCollectionEquality().hash(categoryId) ^
      const DeepCollectionEquality().hash(subjectId) ^
      const DeepCollectionEquality().hash(chapterId) ^
      const DeepCollectionEquality().hash(unitId) ^
      const DeepCollectionEquality().hash(lessons);

  @override
  _$MyCourseCopyWith<_MyCourse> get copyWith =>
      __$MyCourseCopyWithImpl<_MyCourse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_MyCourseToJson(this);
  }
}

abstract class _MyCourse implements MyCourse {
  factory _MyCourse(
      {String id,
      String userId,
      String title,
      String subtitle,
      String cover,
      String categoryId,
      String subjectId,
      String chapterId,
      String unitId,
      List<String> lessons}) = _$_MyCourse;

  factory _MyCourse.fromJson(Map<String, dynamic> json) = _$_MyCourse.fromJson;

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
  String get categoryId;
  @override
  String get subjectId;
  @override
  String get chapterId;
  @override
  String get unitId;
  @override
  List<String> get lessons;
  @override
  _$MyCourseCopyWith<_MyCourse> get copyWith;
}
