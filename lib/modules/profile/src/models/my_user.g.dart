// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MyUser _$_$_MyUserFromJson(Map<String, dynamic> json) {
  return _$_MyUser(
    id: json['id'] as String?,
    name: json['name'] as String?,
    email: json['email'] as String?,
    avatar: json['avatar'] as String?,
    provider: json['provider'] as String?,
    tagline: json['tagline'] as String?,
    isVerified: json['isVerified'] as bool? ?? false,
    selectedCategory: json['selectedCategory'] as String?,
    teaching: json['teaching'] == null
        ? null
        : Teaching.fromJson(json['teaching'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_MyUserToJson(_$_MyUser instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  val['email'] = instance.email;
  writeNotNull('avatar', instance.avatar);
  val['provider'] = instance.provider;
  writeNotNull('tagline', instance.tagline);
  writeNotNull('isVerified', instance.isVerified);
  val['selectedCategory'] = instance.selectedCategory;
  val['teaching'] = instance.teaching;
  return val;
}

_$_Teaching _$_$_TeachingFromJson(Map<String, dynamic> json) {
  return _$_Teaching(
    isTeacher: json['isTeacher'] as bool? ?? false,
    hasSignedCLA: json['hasSignedCLA'] as bool? ?? false,
    isVerified: json['isVerified'] as bool? ?? false,
  );
}

Map<String, dynamic> _$_$_TeachingToJson(_$_Teaching instance) =>
    <String, dynamic>{
      'isTeacher': instance.isTeacher,
      'hasSignedCLA': instance.hasSignedCLA,
      'isVerified': instance.isVerified,
    };
