class VoucherModel {
  VoucherModel({required this.voucherRedemptionHistory});

  final List<VoucherRedemptionHistory> voucherRedemptionHistory;

  factory VoucherModel.fromJson(Map<String, dynamic> json) {
    return VoucherModel(
      voucherRedemptionHistory:
          json["voucherRedemptionHistory"] == null
              ? []
              : List<VoucherRedemptionHistory>.from(
                json["voucherRedemptionHistory"]!.map(
                  (x) => VoucherRedemptionHistory.fromJson(x),
                ),
              ),
    );
  }

  Map<String, dynamic> toJson() => {
    "voucherRedemptionHistory":
        voucherRedemptionHistory.map((x) => x.toJson()).toList(),
  };
}

class VoucherRedemptionHistory {
  VoucherRedemptionHistory({
    required this.compaignName,
    required this.compaignDescription,
    required this.customCode,
    required this.expiryDate,
    required this.amountRedeemed,
    required this.redeemedDate,
  });

  final String? compaignName;
  final String? compaignDescription;
  final String? customCode;
  final String? expiryDate;
  final double? amountRedeemed;
  final DateTime? redeemedDate;

  factory VoucherRedemptionHistory.fromJson(Map<String, dynamic> json) {
    return VoucherRedemptionHistory(
      compaignName: json["compaignName"],
      compaignDescription: json["compaignDescription"],
      customCode: json["customCode"],
      expiryDate: json["expiryDate"],
      amountRedeemed: json["amountRedeemed"],
      redeemedDate: DateTime.tryParse(json["redeemedDate"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "compaignName": compaignName,
    "compaignDescription": compaignDescription,
    "customCode": customCode,
    "expiryDate": expiryDate,
    "amountRedeemed": amountRedeemed,
    "redeemedDate": redeemedDate?.toIso8601String(),
  };
}
