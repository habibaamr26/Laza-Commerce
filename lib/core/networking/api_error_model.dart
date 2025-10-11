

import 'package:json_annotation/json_annotation.dart';
part 'api_error_model.g.dart';

@JsonSerializable()
class ApiErrorModel
{
  late int responseCode;
  late String message;
  final String? errors;

  ApiErrorModel({
    required this.message,
    required this.responseCode,
    this.errors
});
  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);

}