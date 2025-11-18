class ErrorModel {
  ErrorModel({required this.error});

  final Error? error;

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      error: json["error"] == null ? null : Error.fromJson(json["error"]),
    );
  }

  Map<String, dynamic> toJson() => {"error": error?.toJson()};
}

class Error {
  Error({
    required this.code,
    required this.message,
    required this.details,
    this.fields,
    this.userFriendly,
    this.extraData,
  });

  final String? code;
  final String? message;
  final String? details;
  final Fields? fields;
  final UserFriendly? userFriendly;
  final dynamic extraData;

  factory Error.fromJson(Map<String, dynamic> json) {
    return Error(
      code: json["code"],
      message: json["message"],
      details: json["details"],
      fields: json["fields"] == null ? null : Fields.fromJson(json["fields"]),
      userFriendly:
          json["user_friendly"] == null
              ? null
              : UserFriendly.fromJson(json["user_friendly"]),
      extraData: json["extra_data"],
    );
  }

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "details": details,
    "fields": fields?.toJson(),
    "user_friendly": userFriendly?.toJson(),
    "extra_data": extraData,
  };
}

class UserFriendly {
  UserFriendly({this.title, this.description});

  final String? title;
  final String? description;

  factory UserFriendly.fromJson(Map<String, dynamic> json) {
    return UserFriendly(title: json["title"], description: json["description"]);
  }

  Map<String, dynamic> toJson() => {"title": title, "description": description};
}

class Fields {
  Fields({required this.json});
  final Map<String, dynamic> json;

  factory Fields.fromJson(Map<String, dynamic> json) {
    return Fields(json: json);
  }

  Map<String, dynamic> toJson() => {};
}
