class CustomerModel {
  CustomerModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.nationality,
    required this.age,
    required this.confirmedEmail,
    required this.unconfirmedEmail,
    required this.confirmedPhoneNumber,
    required this.organizationId,
    required this.sessionId,
    required this.authenticationToken,
    required this.roles,
    required this.permissions,
    required this.documentsNeedingSignature,
    required this.suspension,
    required this.customerReferralProgram,
    required this.userWallet,
    required this.customer,
  });

  final String? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final dynamic gender;
  final dynamic nationality;
  final dynamic age;
  final bool? confirmedEmail;
  final dynamic unconfirmedEmail;
  final String? confirmedPhoneNumber;
  final String? organizationId;
  final String? sessionId;
  final dynamic authenticationToken;
  final List<dynamic> roles;
  final List<dynamic> permissions;
  final DocumentsNeedingSignature? documentsNeedingSignature;
  final dynamic suspension;
  final dynamic customerReferralProgram;
  final UserWallet? userWallet;
  final Customer? customer;

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json["id"],
      email: json["email"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      gender: json["gender"],
      nationality: json["nationality"],
      age: json["age"],
      confirmedEmail: json["confirmed_email"],
      unconfirmedEmail: json["unconfirmed_email"],
      confirmedPhoneNumber: json["confirmed_phone_number"],
      organizationId: json["organization_id"],
      sessionId: json["session_id"],
      authenticationToken: json["authentication_token"],
      roles:
          json["roles"] == null
              ? []
              : List<dynamic>.from(json["roles"]!.map((x) => x)),
      permissions:
          json["permissions"] == null
              ? []
              : List<dynamic>.from(json["permissions"]!.map((x) => x)),
      documentsNeedingSignature:
          json["documents_needing_signature"] == null
              ? null
              : DocumentsNeedingSignature.fromJson(
                json["documents_needing_signature"],
              ),
      suspension: json["suspension"],
      customerReferralProgram: json["customer_referral_program"],
      userWallet:
          json["user_wallet"] == null
              ? null
              : UserWallet.fromJson(json["user_wallet"]),
      customer:
          json["customer"] == null ? null : Customer.fromJson(json["customer"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "gender": gender,
    "nationality": nationality,
    "age": age,
    "confirmed_email": confirmedEmail,
    "unconfirmed_email": unconfirmedEmail,
    "confirmed_phone_number": confirmedPhoneNumber,
    "organization_id": organizationId,
    "session_id": sessionId,
    "authentication_token": authenticationToken,
    "roles": roles.map((x) => x).toList(),
    "permissions": permissions.map((x) => x).toList(),
    "documents_needing_signature": documentsNeedingSignature?.toJson(),
    "suspension": suspension,
    "customer_referral_program": customerReferralProgram,
    "user_wallet": userWallet?.toJson(),
    "customer": customer?.toJson(),
  };
}

class Customer {
  Customer({
    required this.resourceId,
    required this.userId,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? resourceId;
  final String? userId;
  final String? createdBy;
  final String? updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      resourceId: json["resourceId"],
      userId: json["userId"],
      createdBy: json["createdBy"],
      updatedBy: json["updatedBy"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "resourceId": resourceId,
    "userId": userId,
    "createdBy": createdBy,
    "updatedBy": updatedBy,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class DocumentsNeedingSignature {
  DocumentsNeedingSignature({required this.passengerLegal});

  final bool? passengerLegal;

  factory DocumentsNeedingSignature.fromJson(Map<String, dynamic> json) {
    return DocumentsNeedingSignature(passengerLegal: json["passenger_legal"]);
  }

  Map<String, dynamic> toJson() => {"passenger_legal": passengerLegal};
}

class UserWallet {
  UserWallet({
    required this.resourceId,
    required this.organizationId,
    required this.userId,
    required this.balance,
    required this.currency,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? resourceId;
  final String? organizationId;
  final String? userId;
  final double? balance;
  final String? currency;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory UserWallet.fromJson(Map<String, dynamic> json) {
    return UserWallet(
      resourceId: json["resourceId"],
      organizationId: json["organizationId"],
      userId: json["userId"],
      balance: json["balance"],
      currency: json["currency"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "resourceId": resourceId,
    "organizationId": organizationId,
    "userId": userId,
    "balance": balance,
    "currency": currency,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
