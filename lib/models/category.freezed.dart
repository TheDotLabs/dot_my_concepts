// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Category _$CategoryFromJson(Map<String, dynamic> json) {
  return _Category.fromJson(json);
}

class _$CategoryTearOff {
  const _$CategoryTearOff();

// ignore: unused_element
  _Category call(
      {String id,
      String title,
      String description,
      String image,
      List<MySubject> subjects}) {
    return _Category(
      id: id,
      title: title,
      description: description,
      image: image,
      subjects: subjects,
    );
  }
}

// ignore: unused_element
const $Category = _$CategoryTearOff();

mixin _$Category {
  String get id;
  String get title;
  String get description;
  String get image;
  List<MySubject> get subjects;

  Map<String, dynamic> toJson();
  $CategoryCopyWith<Category> get copyWith;
}

abstract class $CategoryCopyWith<$Res> {
  factory $CategoryCopyWith(Category value, $Res Function(Category) then) =
      _$CategoryCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String title,
      String description,
      String image,
      List<MySubject> subjects});
}

class _$CategoryCopyWithImpl<$Res> implements $CategoryCopyWith<$Res> {
  _$CategoryCopyWithImpl(this._value, this._then);

  final Category _value;
  // ignore: unused_field
  final $Res Function(Category) _then;

  @override
  $Res call({
    Object id = freezed,
    Object title = freezed,
    Object description = freezed,
    Object image = freezed,
    Object subjects = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      title: title == freezed ? _value.title : title as String,
      description:
          description == freezed ? _value.description : description as String,
      image: image == freezed ? _value.image : image as String,
      subjects:
          subjects == freezed ? _value.subjects : subjects as List<MySubject>,
    ));
  }
}

abstract class _$CategoryCopyWith<$Res> implements $CategoryCopyWith<$Res> {
  factory _$CategoryCopyWith(_Category value, $Res Function(_Category) then) =
      __$CategoryCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String title,
      String description,
      String image,
      List<MySubject> subjects});
}

class __$CategoryCopyWithImpl<$Res> extends _$CategoryCopyWithImpl<$Res>
    implements _$CategoryCopyWith<$Res> {
  __$CategoryCopyWithImpl(_Category _value, $Res Function(_Category) _then)
      : super(_value, (v) => _then(v as _Category));

  @override
  _Category get _value => super._value as _Category;

  @override
  $Res call({
    Object id = freezed,
    Object title = freezed,
    Object description = freezed,
    Object image = freezed,
    Object subjects = freezed,
  }) {
    return _then(_Category(
      id: id == freezed ? _value.id : id as String,
      title: title == freezed ? _value.title : title as String,
      description:
          description == freezed ? _value.description : description as String,
      image: image == freezed ? _value.image : image as String,
      subjects:
          subjects == freezed ? _value.subjects : subjects as List<MySubject>,
    ));
  }
}

@JsonSerializable()
class _$_Category implements _Category {
  _$_Category(
      {this.id, this.title, this.description, this.image, this.subjects});

  factory _$_Category.fromJson(Map<String, dynamic> json) =>
      _$_$_CategoryFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String image;
  @override
  final List<MySubject> subjects;

  @override
  String toString() {
    return 'Category(id: $id, title: $title, description: $description, image: $image, subjects: $subjects)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Category &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.image, image) ||
                const DeepCollectionEquality().equals(other.image, image)) &&
            (identical(other.subjects, subjects) ||
                const DeepCollectionEquality()
                    .equals(other.subjects, subjects)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(image) ^
      const DeepCollectionEquality().hash(subjects);

  @override
  _$CategoryCopyWith<_Category> get copyWith =>
      __$CategoryCopyWithImpl<_Category>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CategoryToJson(this);
  }
}

abstract class _Category implements Category {
  factory _Category(
      {String id,
      String title,
      String description,
      String image,
      List<MySubject> subjects}) = _$_Category;

  factory _Category.fromJson(Map<String, dynamic> json) = _$_Category.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get image;
  @override
  List<MySubject> get subjects;
  @override
  _$CategoryCopyWith<_Category> get copyWith;
}

MySubject _$MySubjectFromJson(Map<String, dynamic> json) {
  return _MySubject.fromJson(json);
}

class _$MySubjectTearOff {
  const _$MySubjectTearOff();

// ignore: unused_element
  _MySubject call(
      {String id, String title, String description, List<MyUnit> units}) {
    return _MySubject(
      id: id,
      title: title,
      description: description,
      units: units,
    );
  }
}

// ignore: unused_element
const $MySubject = _$MySubjectTearOff();

mixin _$MySubject {
  String get id;
  String get title;
  String get description;
  List<MyUnit> get units;

  Map<String, dynamic> toJson();
  $MySubjectCopyWith<MySubject> get copyWith;
}

abstract class $MySubjectCopyWith<$Res> {
  factory $MySubjectCopyWith(MySubject value, $Res Function(MySubject) then) =
      _$MySubjectCopyWithImpl<$Res>;
  $Res call({String id, String title, String description, List<MyUnit> units});
}

class _$MySubjectCopyWithImpl<$Res> implements $MySubjectCopyWith<$Res> {
  _$MySubjectCopyWithImpl(this._value, this._then);

  final MySubject _value;
  // ignore: unused_field
  final $Res Function(MySubject) _then;

  @override
  $Res call({
    Object id = freezed,
    Object title = freezed,
    Object description = freezed,
    Object units = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      title: title == freezed ? _value.title : title as String,
      description:
          description == freezed ? _value.description : description as String,
      units: units == freezed ? _value.units : units as List<MyUnit>,
    ));
  }
}

abstract class _$MySubjectCopyWith<$Res> implements $MySubjectCopyWith<$Res> {
  factory _$MySubjectCopyWith(
          _MySubject value, $Res Function(_MySubject) then) =
      __$MySubjectCopyWithImpl<$Res>;
  @override
  $Res call({String id, String title, String description, List<MyUnit> units});
}

class __$MySubjectCopyWithImpl<$Res> extends _$MySubjectCopyWithImpl<$Res>
    implements _$MySubjectCopyWith<$Res> {
  __$MySubjectCopyWithImpl(_MySubject _value, $Res Function(_MySubject) _then)
      : super(_value, (v) => _then(v as _MySubject));

  @override
  _MySubject get _value => super._value as _MySubject;

  @override
  $Res call({
    Object id = freezed,
    Object title = freezed,
    Object description = freezed,
    Object units = freezed,
  }) {
    return _then(_MySubject(
      id: id == freezed ? _value.id : id as String,
      title: title == freezed ? _value.title : title as String,
      description:
          description == freezed ? _value.description : description as String,
      units: units == freezed ? _value.units : units as List<MyUnit>,
    ));
  }
}

@JsonSerializable()
class _$_MySubject implements _MySubject {
  _$_MySubject({this.id, this.title, this.description, this.units});

  factory _$_MySubject.fromJson(Map<String, dynamic> json) =>
      _$_$_MySubjectFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final List<MyUnit> units;

  @override
  String toString() {
    return 'MySubject(id: $id, title: $title, description: $description, units: $units)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MySubject &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.units, units) ||
                const DeepCollectionEquality().equals(other.units, units)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(units);

  @override
  _$MySubjectCopyWith<_MySubject> get copyWith =>
      __$MySubjectCopyWithImpl<_MySubject>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_MySubjectToJson(this);
  }
}

abstract class _MySubject implements MySubject {
  factory _MySubject(
      {String id,
      String title,
      String description,
      List<MyUnit> units}) = _$_MySubject;

  factory _MySubject.fromJson(Map<String, dynamic> json) =
      _$_MySubject.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  List<MyUnit> get units;
  @override
  _$MySubjectCopyWith<_MySubject> get copyWith;
}

MyUnit _$MyUnitFromJson(Map<String, dynamic> json) {
  return _MyUnit.fromJson(json);
}

class _$MyUnitTearOff {
  const _$MyUnitTearOff();

// ignore: unused_element
  _MyUnit call(
      {String id, String title, String description, List<MyChapter> chapters}) {
    return _MyUnit(
      id: id,
      title: title,
      description: description,
      chapters: chapters,
    );
  }
}

// ignore: unused_element
const $MyUnit = _$MyUnitTearOff();

mixin _$MyUnit {
  String get id;
  String get title;
  String get description;
  List<MyChapter> get chapters;

  Map<String, dynamic> toJson();
  $MyUnitCopyWith<MyUnit> get copyWith;
}

abstract class $MyUnitCopyWith<$Res> {
  factory $MyUnitCopyWith(MyUnit value, $Res Function(MyUnit) then) =
      _$MyUnitCopyWithImpl<$Res>;
  $Res call(
      {String id, String title, String description, List<MyChapter> chapters});
}

class _$MyUnitCopyWithImpl<$Res> implements $MyUnitCopyWith<$Res> {
  _$MyUnitCopyWithImpl(this._value, this._then);

  final MyUnit _value;
  // ignore: unused_field
  final $Res Function(MyUnit) _then;

  @override
  $Res call({
    Object id = freezed,
    Object title = freezed,
    Object description = freezed,
    Object chapters = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      title: title == freezed ? _value.title : title as String,
      description:
          description == freezed ? _value.description : description as String,
      chapters:
          chapters == freezed ? _value.chapters : chapters as List<MyChapter>,
    ));
  }
}

abstract class _$MyUnitCopyWith<$Res> implements $MyUnitCopyWith<$Res> {
  factory _$MyUnitCopyWith(_MyUnit value, $Res Function(_MyUnit) then) =
      __$MyUnitCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id, String title, String description, List<MyChapter> chapters});
}

class __$MyUnitCopyWithImpl<$Res> extends _$MyUnitCopyWithImpl<$Res>
    implements _$MyUnitCopyWith<$Res> {
  __$MyUnitCopyWithImpl(_MyUnit _value, $Res Function(_MyUnit) _then)
      : super(_value, (v) => _then(v as _MyUnit));

  @override
  _MyUnit get _value => super._value as _MyUnit;

  @override
  $Res call({
    Object id = freezed,
    Object title = freezed,
    Object description = freezed,
    Object chapters = freezed,
  }) {
    return _then(_MyUnit(
      id: id == freezed ? _value.id : id as String,
      title: title == freezed ? _value.title : title as String,
      description:
          description == freezed ? _value.description : description as String,
      chapters:
          chapters == freezed ? _value.chapters : chapters as List<MyChapter>,
    ));
  }
}

@JsonSerializable()
class _$_MyUnit implements _MyUnit {
  _$_MyUnit({this.id, this.title, this.description, this.chapters});

  factory _$_MyUnit.fromJson(Map<String, dynamic> json) =>
      _$_$_MyUnitFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final List<MyChapter> chapters;

  @override
  String toString() {
    return 'MyUnit(id: $id, title: $title, description: $description, chapters: $chapters)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MyUnit &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.chapters, chapters) ||
                const DeepCollectionEquality()
                    .equals(other.chapters, chapters)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(chapters);

  @override
  _$MyUnitCopyWith<_MyUnit> get copyWith =>
      __$MyUnitCopyWithImpl<_MyUnit>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_MyUnitToJson(this);
  }
}

abstract class _MyUnit implements MyUnit {
  factory _MyUnit(
      {String id,
      String title,
      String description,
      List<MyChapter> chapters}) = _$_MyUnit;

  factory _MyUnit.fromJson(Map<String, dynamic> json) = _$_MyUnit.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  List<MyChapter> get chapters;
  @override
  _$MyUnitCopyWith<_MyUnit> get copyWith;
}

MyChapter _$MyChapterFromJson(Map<String, dynamic> json) {
  return _MyChapter.fromJson(json);
}

class _$MyChapterTearOff {
  const _$MyChapterTearOff();

// ignore: unused_element
  _MyChapter call({String id, String title, String description}) {
    return _MyChapter(
      id: id,
      title: title,
      description: description,
    );
  }
}

// ignore: unused_element
const $MyChapter = _$MyChapterTearOff();

mixin _$MyChapter {
  String get id;
  String get title;
  String get description;

  Map<String, dynamic> toJson();
  $MyChapterCopyWith<MyChapter> get copyWith;
}

abstract class $MyChapterCopyWith<$Res> {
  factory $MyChapterCopyWith(MyChapter value, $Res Function(MyChapter) then) =
      _$MyChapterCopyWithImpl<$Res>;
  $Res call({String id, String title, String description});
}

class _$MyChapterCopyWithImpl<$Res> implements $MyChapterCopyWith<$Res> {
  _$MyChapterCopyWithImpl(this._value, this._then);

  final MyChapter _value;
  // ignore: unused_field
  final $Res Function(MyChapter) _then;

  @override
  $Res call({
    Object id = freezed,
    Object title = freezed,
    Object description = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      title: title == freezed ? _value.title : title as String,
      description:
          description == freezed ? _value.description : description as String,
    ));
  }
}

abstract class _$MyChapterCopyWith<$Res> implements $MyChapterCopyWith<$Res> {
  factory _$MyChapterCopyWith(
          _MyChapter value, $Res Function(_MyChapter) then) =
      __$MyChapterCopyWithImpl<$Res>;
  @override
  $Res call({String id, String title, String description});
}

class __$MyChapterCopyWithImpl<$Res> extends _$MyChapterCopyWithImpl<$Res>
    implements _$MyChapterCopyWith<$Res> {
  __$MyChapterCopyWithImpl(_MyChapter _value, $Res Function(_MyChapter) _then)
      : super(_value, (v) => _then(v as _MyChapter));

  @override
  _MyChapter get _value => super._value as _MyChapter;

  @override
  $Res call({
    Object id = freezed,
    Object title = freezed,
    Object description = freezed,
  }) {
    return _then(_MyChapter(
      id: id == freezed ? _value.id : id as String,
      title: title == freezed ? _value.title : title as String,
      description:
          description == freezed ? _value.description : description as String,
    ));
  }
}

@JsonSerializable()
class _$_MyChapter implements _MyChapter {
  _$_MyChapter({this.id, this.title, this.description});

  factory _$_MyChapter.fromJson(Map<String, dynamic> json) =>
      _$_$_MyChapterFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;

  @override
  String toString() {
    return 'MyChapter(id: $id, title: $title, description: $description)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MyChapter &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(description);

  @override
  _$MyChapterCopyWith<_MyChapter> get copyWith =>
      __$MyChapterCopyWithImpl<_MyChapter>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_MyChapterToJson(this);
  }
}

abstract class _MyChapter implements MyChapter {
  factory _MyChapter({String id, String title, String description}) =
      _$_MyChapter;

  factory _MyChapter.fromJson(Map<String, dynamic> json) =
      _$_MyChapter.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  _$MyChapterCopyWith<_MyChapter> get copyWith;
}
