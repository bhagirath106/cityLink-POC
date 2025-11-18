class WalletModel {
  WalletModel({
    required this.activePaymentMethodId,
    required this.tapCustomerId,
    required this.paymentMethods,
  });

  final String? activePaymentMethodId;
  final String? tapCustomerId;
  final List<PaymentMethod> paymentMethods;

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      activePaymentMethodId: json["active_payment_method_id"],
      tapCustomerId: json["tap_customer_id"],
      paymentMethods:
          json["payment_methods"] == null
              ? []
              : List<PaymentMethod>.from(
                json["payment_methods"]!.map((x) => PaymentMethod.fromJson(x)),
              ),
    );
  }

  Map<String, dynamic> toJson() => {
    "active_payment_method_id": activePaymentMethodId,
    "tap_customer_id": tapCustomerId,
    "payment_methods": paymentMethods.map((x) => x.toJson()).toList(),
  };
}

class PaymentMethod {
  PaymentMethod({
    required this.id,
    required this.type,
    required this.processor,
    required this.properties,
  });

  final String? id;
  final String? type;
  final String? processor;
  final Properties? properties;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      id: json["id"],
      type: json["type"],
      processor: json["processor"],
      properties:
          json["properties"] == null
              ? null
              : Properties.fromJson(json["properties"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "processor": processor,
    "properties": properties?.toJson(),
  };
}

class Properties {
  Properties({required this.minimumBalance, required this.minimumRecharge});

  final double? minimumBalance;
  final double? minimumRecharge;

  factory Properties.fromJson(Map<String, dynamic> json) {
    return Properties(
      minimumBalance: json["minimum_balance"],
      minimumRecharge: json["minimum_recharge"],
    );
  }

  Map<String, dynamic> toJson() => {
    "minimum_balance": minimumBalance,
    "minimum_recharge": minimumRecharge,
  };
}
