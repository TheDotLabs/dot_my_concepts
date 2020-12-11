import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_user.freezed.dart';
part 'my_user.g.dart';

@freezed
abstract class MyUser with _$MyUser {
  factory MyUser({
    String id,
    @JsonKey(includeIfNull: false) String name,
    String email,
    @JsonKey(includeIfNull: false) String avatar,
    String provider,
    @JsonKey(includeIfNull: false) String tagline,
    @JsonKey(includeIfNull: false, defaultValue: false) bool isVerified,
    String selectedCategory,
  }) = _MyUser;

  factory MyUser.fromJson(Map<String, dynamic> json) => _$MyUserFromJson(json);
}
