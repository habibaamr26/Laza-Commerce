import 'package:json_annotation/json_annotation.dart';
part 'response.g.dart';
@JsonSerializable()
class LoginResponseModel {
  final String? accessToken;
  final String? expiresAtUtc;
  final String? refreshToken;
  LoginResponseModel({
    required this.accessToken,
    required this.expiresAtUtc,
    required this.refreshToken,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}
