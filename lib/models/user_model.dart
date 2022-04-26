import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';
@JsonSerializable()
class UserModel {
  final String? displayName;
  final String? email;
  final bool? emailVerified;
  final bool? isAnonymous;

  const UserModel(
      {this.displayName, this.email, this.emailVerified, this.isAnonymous});
  factory UserModel.fromJson(Map<String,dynamic> json)=>_$UserModelFromJson(json);
  Map<String,dynamic> toJson() => _$UserModelToJson(this);
}
