import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';
@JsonSerializable()
class UserModel {
  final String? totalAttendance;
  final int? totalPower;
  final String? totalStar;

  const UserModel(
      {this.totalAttendance, this.totalPower, this.totalStar});
  factory UserModel.fromJson(Map<String,dynamic> json)=>_$UserModelFromJson(json);
  Map<String,dynamic> toJson() => _$UserModelToJson(this);
}
