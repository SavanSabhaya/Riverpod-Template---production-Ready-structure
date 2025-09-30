import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
@HiveType(typeId: 0)
class User with _$User {
  const factory User({
    @HiveField(0) required String id,
    @HiveField(1) required String email,
    @HiveField(2) required String name,
    @HiveField(3) String? avatar,
    @HiveField(4) String? phone,
    @HiveField(5) DateTime? createdAt,
    @HiveField(6) DateTime? updatedAt,
    @HiveField(7) Map<String, dynamic>? metadata,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  const User._();

  String get displayName => name.isNotEmpty ? name : email;

  String get initials {
    final nameParts = name.split(' ');
    if (nameParts.length >= 2) {
      return '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : email[0].toUpperCase();
  }

  bool get hasAvatar => avatar != null && avatar!.isNotEmpty;

  bool get hasPhone => phone != null && phone!.isNotEmpty;
}
