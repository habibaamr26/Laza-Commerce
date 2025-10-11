
import 'package:json_annotation/json_annotation.dart';
part 'response_model.g.dart';

@JsonSerializable()
class ResponseModel
{
  final int? statusCode;
  final String? message;
  final Map<String, List<String>>? errors;

  ResponseModel({
    this.statusCode,
    this.message,
    this.errors,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);
}
