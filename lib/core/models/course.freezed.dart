// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'course.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MyCourse _$MyCourseFromJson(Map<String, dynamic> json) {
  return _MyCourse.fromJson(json);
}

/// @nodoc
class _$MyCourseTearOff {
  const _$MyCourseTearOff();

  _MyCourse call(
      {required String id,
      required String userId,
      required String categoryId,
      required String subjectId,
      required String chapterId,
      required String unitId,
      List<Rating>? rating,
      String? title,
      String? subtitle,
      String? cover,
      List<String>? lessons}) {
    return _MyCourse(
      id: id,
      userId: userId,
      categoryId: categoryId,
      subjectId: subjectId,
      chapterId: chapterId,
      unitId: unitId,
      rating: rating,
      title: title,
      subtitle: subtitle,
      cover: cover,
      lessons: lessons,
    );
  }

  MyCourse fromJson(Map<String, Object> json) {
    return MyCourse.fromJson(json);
  }
}

/// @nodoc
const $MyCourse = _$MyCourseTearOff();

/// @nodoc
mixin _$MyCourse {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get categoryId => throw _privateConstructorUsedError;
  String get subjectId => throw _privateConstructorUsedError;
  String get chapterId => throw _privateConstructorUsedError;
  String get unitId => throw _privateConstructorUsedError;
  List<Rating>? get rating => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get subtitle => throw _privateConstructorUsedError;
  String? get cover => throw _privateConstructorUsedError;
  List<String>? get lessons => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MyCourseCopyWith<MyCourse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyCourseCopyWith<$Res> {
  factory $MyCourseCopyWith(MyCourse value, $Res Function(MyCourse) then) =
      _$MyCourseCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String userId,
      String categoryId,
      String subjectId,
      String chapterId,
      String unitId,
      List<Rating>? rating,
      String? title,
      String? subtitle,
      String? cover,
      List<String>? lessons});
}

/// @nodoc
class _$MyCourseCopyWithImpl<$Res> implements $MyCourseCopyWith<$Res> {
  _$MyCourseCopyWithImpl(this._value, this._then);

  final MyCourse _value;
  // ignore: unused_field
  final $Res Function(MyCourse) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? categoryId = freezed,
    Object? subjectId = freezed,
    Object? chapterId = freezed,
    Object? unitId = freezed,
    Object? rating = freezed,
    Object? title = freezed,
    Object? subtitle = freezed,
    Object? cover = freezed,
    Object? lessons = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: categoryId == freezed
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      subjectId: subjectId == freezed
          ? _value.subjectId
          : subjectId // ignore: cast_nullable_to_non_nullable
              as String,
      chapterId: chapterId == freezed
          ? _value.chapterId
          : chapterId // ignore: cast_nullable_to_non_nullable
              as String,
      unitId: unitId == freezed
          ? _value.unitId
          : unitId // ignore: cast_nullable_to_non_nullable
              as String,
      rating: rating == freezed
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as List<Rating>?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      subtitle: subtitle == freezed
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
      cover: cover == freezed
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as String?,
      lessons: lessons == freezed
          ? _value.lessons
          : lessons // ignore: cast_nullable_to_non_nullable
              as List<String>?,
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
      String categoryId,
      String subjectId,
      String chapterId,
      String unitId,
      List<Rating>? rating,
      String? title,
      String? subtitle,
      String? cover,
      List<String>? lessons});
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
    Object? id = freezed,
    Object? userId = freezed,
    Object? categoryId = freezed,
    Object? subjectId = freezed,
    Object? chapterId = freezed,
    Object? unitId = freezed,
    Object? rating = freezed,
    Object? title = freezed,
    Object? subtitle = freezed,
    Object? cover = freezed,
    Object? lessons = freezed,
  }) {
    return _then(_MyCourse(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      categoryId: categoryId == freezed
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String,
      subjectId: subjectId == freezed
          ? _value.subjectId
          : subjectId // ignore: cast_nullable_to_non_nullable
              as String,
      chapterId: chapterId == freezed
          ? _value.chapterId
          : chapterId // ignore: cast_nullable_to_non_nullable
              as String,
      unitId: unitId == freezed
          ? _value.unitId
          : unitId // ignore: cast_nullable_to_non_nullable
              as String,
      rating: rating == freezed
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as List<Rating>?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      subtitle: subtitle == freezed
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
      cover: cover == freezed
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as String?,
      lessons: lessons == freezed
          ? _value.lessons
          : lessons // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MyCourse implements _MyCourse {
  _$_MyCourse(
      {required this.id,
      required this.userId,
      required this.categoryId,
      required this.subjectId,
      required this.chapterId,
      required this.unitId,
      this.rating,
      this.title,
      this.subtitle,
      this.cover,
      this.lessons});

  factory _$_MyCourse.fromJson(Map<String, dynamic> json) =>
      _$_$_MyCourseFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String categoryId;
  @override
  final String subjectId;
  @override
  final String chapterId;
  @override
  final String unitId;
  @override
  final List<Rating>? rating;
  @override
  final String? title;
  @override
  final String? subtitle;
  @override
  final String? cover;
  @override
  final List<String>? lessons;

  @override
  String toString() {
    return 'MyCourse(id: $id, userId: $userId, categoryId: $categoryId, subjectId: $subjectId, chapterId: $chapterId, unitId: $unitId, rating: $rating, title: $title, subtitle: $subtitle, cover: $cover, lessons: $lessons)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MyCourse &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
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
            (identical(other.rating, rating) ||
                const DeepCollectionEquality().equals(other.rating, rating)) &&
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
      const DeepCollectionEquality().hash(categoryId) ^
      const DeepCollectionEquality().hash(subjectId) ^
      const DeepCollectionEquality().hash(chapterId) ^
      const DeepCollectionEquality().hash(unitId) ^
      const DeepCollectionEquality().hash(rating) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(subtitle) ^
      const DeepCollectionEquality().hash(cover) ^
      const DeepCollectionEquality().hash(lessons);

  @JsonKey(ignore: true)
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
      {required String id,
      required String userId,
      required String categoryId,
      required String subjectId,
      required String chapterId,
      required String unitId,
      List<Rating>? rating,
      String? title,
      String? subtitle,
      String? cover,
      List<String>? lessons}) = _$_MyCourse;

  factory _MyCourse.fromJson(Map<String, dynamic> json) = _$_MyCourse.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String get userId => throw _privateConstructorUsedError;
  @override
  String get categoryId => throw _privateConstructorUsedError;
  @override
  String get subjectId => throw _privateConstructorUsedError;
  @override
  String get chapterId => throw _privateConstructorUsedError;
  @override
  String get unitId => throw _privateConstructorUsedError;
  @override
  List<Rating>? get rating => throw _privateConstructorUsedError;
  @override
  String? get title => throw _privateConstructorUsedError;
  @override
  String? get subtitle => throw _privateConstructorUsedError;
  @override
  String? get cover => throw _privateConstructorUsedError;
  @override
  List<String>? get lessons => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MyCourseCopyWith<_MyCourse> get copyWith =>
      throw _privateConstructorUsedError;
}

Rating _$RatingFromJson(Map<String, dynamic> json) {
  return _Rating.fromJson(json);
}

/// @nodoc
class _$RatingTearOff {
  const _$RatingTearOff();

  _Rating call(
      {required double number,
      required String userId,
      required String? review}) {
    return _Rating(
      number: number,
      userId: userId,
      review: review,
    );
  }

  Rating fromJson(Map<String, Object> json) {
    return Rating.fromJson(json);
  }
}

/// @nodoc
const $Rating = _$RatingTearOff();

/// @nodoc
mixin _$Rating {
  double get number => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String? get review => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RatingCopyWith<Rating> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RatingCopyWith<$Res> {
  factory $RatingCopyWith(Rating value, $Res Function(Rating) then) =
      _$RatingCopyWithImpl<$Res>;
  $Res call({double number, String userId, String? review});
}

/// @nodoc
class _$RatingCopyWithImpl<$Res> implements $RatingCopyWith<$Res> {
  _$RatingCopyWithImpl(this._value, this._then);

  final Rating _value;
  // ignore: unused_field
  final $Res Function(Rating) _then;

  @override
  $Res call({
    Object? number = freezed,
    Object? userId = freezed,
    Object? review = freezed,
  }) {
    return _then(_value.copyWith(
      number: number == freezed
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as double,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      review: review == freezed
          ? _value.review
          : review // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$RatingCopyWith<$Res> implements $RatingCopyWith<$Res> {
  factory _$RatingCopyWith(_Rating value, $Res Function(_Rating) then) =
      __$RatingCopyWithImpl<$Res>;
  @override
  $Res call({double number, String userId, String? review});
}

/// @nodoc
class __$RatingCopyWithImpl<$Res> extends _$RatingCopyWithImpl<$Res>
    implements _$RatingCopyWith<$Res> {
  __$RatingCopyWithImpl(_Rating _value, $Res Function(_Rating) _then)
      : super(_value, (v) => _then(v as _Rating));

  @override
  _Rating get _value => super._value as _Rating;

  @override
  $Res call({
    Object? number = freezed,
    Object? userId = freezed,
    Object? review = freezed,
  }) {
    return _then(_Rating(
      number: number == freezed
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as double,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      review: review == freezed
          ? _value.review
          : review // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Rating implements _Rating {
  _$_Rating({required this.number, required this.userId, required this.review});

  factory _$_Rating.fromJson(Map<String, dynamic> json) =>
      _$_$_RatingFromJson(json);

  @override
  final double number;
  @override
  final String userId;
  @override
  final String? review;

  @override
  String toString() {
    return 'Rating(number: $number, userId: $userId, review: $review)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Rating &&
            (identical(other.number, number) ||
                const DeepCollectionEquality().equals(other.number, number)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.review, review) ||
                const DeepCollectionEquality().equals(other.review, review)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(number) ^
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(review);

  @JsonKey(ignore: true)
  @override
  _$RatingCopyWith<_Rating> get copyWith =>
      __$RatingCopyWithImpl<_Rating>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_RatingToJson(this);
  }
}

abstract class _Rating implements Rating {
  factory _Rating(
      {required double number,
      required String userId,
      required String? review}) = _$_Rating;

  factory _Rating.fromJson(Map<String, dynamic> json) = _$_Rating.fromJson;

  @override
  double get number => throw _privateConstructorUsedError;
  @override
  String get userId => throw _privateConstructorUsedError;
  @override
  String? get review => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$RatingCopyWith<_Rating> get copyWith => throw _privateConstructorUsedError;
}
