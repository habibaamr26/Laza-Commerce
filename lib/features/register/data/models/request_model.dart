
import 'package:json_annotation/json_annotation.dart';
part 'request_model.g.dart';

@JsonSerializable()

class RequestModel{
   final String email;
   final String password;
  final String firstName;
   final String lastName;

  RequestModel({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });


  factory RequestModel.fromJson(Map<String, dynamic> json) =>
      _$RequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestModelToJson(this);
}