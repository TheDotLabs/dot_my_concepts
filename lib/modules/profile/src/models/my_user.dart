import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_user.freezed.dart';
part 'my_user.g.dart';

@freezed
abstract class MyUser with _$MyUser {
  factory MyUser({
    String? id,
    @JsonKey(includeIfNull: false) String? name,
    String? email,
    @JsonKey(includeIfNull: false) String? avatar,
    String? provider,
    @JsonKey(includeIfNull: false) String? tagline,
    @JsonKey(includeIfNull: false, defaultValue: false) bool? isVerified,
    String? selectedCategory,
    Teaching? teaching,
  }) = _MyUser;

  factory MyUser.fromJson(Map<String, dynamic> json) => _$MyUserFromJson(json);
}

@freezed
abstract class Teaching with _$Teaching {
  factory Teaching({
    @JsonKey(defaultValue: false) bool? isTeacher,
    @JsonKey(defaultValue: false) bool? hasSignedCLA,
    @JsonKey(defaultValue: false) bool? isVerified,
  }) = _Teaching;

  factory Teaching.fromJson(Map<String, dynamic> json) =>
      _$TeachingFromJson(json);
}
