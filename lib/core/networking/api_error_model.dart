
class ApiErrorModel
{
  late int? statusCode;
  late String? message;
  final List<String> errors;

  ApiErrorModel({
    required this.message,
    required this.statusCode,
    required this.errors
});
  factory ApiErrorModel.fromJson(Map<String, dynamic> json){
    final allErrors = json['errors'] as Map<String, dynamic>?;
    List<String> errors = [];
    if (allErrors != null) {
      allErrors?.forEach((key, value) {
        for (var v in (value as List)) {
          errors.add("$key : ${v}");
        }
      });
    }
      return ApiErrorModel(
          message: json['message']??"Unknown error",
          statusCode: json['statusCode']??0,
          errors: errors);
    }



}

/* Example JSON response:{
    "email": [
      "Email is not valid."
    ],
    "password": [
      "Password is required.",
      "Password must be at least 8 characters.",
      "Password must contain at least one uppercase letter.",
      "Password must contain at least one lowercase letter.",
      "Password must contain at least one digit.",
      "Password must contain at least one special character."
    ],
    "firstName": [
      "First name is required.",
      "First name must be at least 3 characters."
    ],
    "lastName": [
      "Last name is required.",
      "Last name must be at least 3 characters."
    ]
  }*/