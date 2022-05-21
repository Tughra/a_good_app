// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      totalAttendance: json['totalAttendance'] as String?,
      totalPower: json['totalPower'] as int?,
      totalStar: json['totalStar'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'totalAttendance': instance.totalAttendance,
      'totalPower': instance.totalPower,
      'totalStar': instance.totalStar,
    };
