class AuthenticationSuccessModel {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? gender;
  final String? age;
  final String? nationality;
  final String? id;
  final String? organizationId;
  final bool? confirmedEmail;
  final dynamic unconfirmedEmail;
  final String? confirmedPhoneNumber;
  final List<dynamic> roles;
  final dynamic suspension;
  final ProductMetadata? productMetadata;
  final String? sessionId;
  final String? authenticationToken;

  AuthenticationSuccessModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.age,
    required this.nationality,
    required this.id,
    required this.organizationId,
    required this.confirmedEmail,
    required this.unconfirmedEmail,
    required this.confirmedPhoneNumber,
    required this.roles,
    required this.suspension,
    required this.productMetadata,
    required this.sessionId,
    required this.authenticationToken,
  });

  factory AuthenticationSuccessModel.fromJson(Map<String, dynamic> json) {
    return AuthenticationSuccessModel(
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      gender: json["gender"],
      age: json["age"],
      nationality: json["nationality"],
      id: json["id"],
      organizationId: json["organization_id"],
      confirmedEmail: json["confirmed_email"],
      unconfirmedEmail: json["unconfirmed_email"],
      confirmedPhoneNumber: json["confirmed_phone_number"],
      roles:
          json["roles"] == null
              ? []
              : List<dynamic>.from(json["roles"]!.map((x) => x)),
      suspension: json["suspension"],
      productMetadata:
          json["product_metadata"] == null
              ? null
              : ProductMetadata.fromJson(json["product_metadata"]),
      sessionId: json["session_id"],
      authenticationToken: json["authentication_token"],
    );
  }

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "gender": gender,
    "age": age,
    "nationality": nationality,
    "id": id,
    "organization_id": organizationId,
    "confirmed_email": confirmedEmail,
    "unconfirmed_email": unconfirmedEmail,
    "confirmed_phone_number": confirmedPhoneNumber,
    "roles": roles.map((x) => x).toList(),
    "suspension": suspension,
    "product_metadata": productMetadata?.toJson(),
    "session_id": sessionId,
    "authentication_token": authenticationToken,
  };
}

class ProductMetadata {
  ProductMetadata({required this.json});
  final Map<String, dynamic> json;

  factory ProductMetadata.fromJson(Map<String, dynamic> json) {
    return ProductMetadata(json: json);
  }

  Map<String, dynamic> toJson() => {};
}
