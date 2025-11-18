class RedeemVoucherModel {
  RedeemVoucherModel({required this.redeemVoucher});

  final RedeemVoucher? redeemVoucher;

  factory RedeemVoucherModel.fromJson(Map<String, dynamic> json) {
    return RedeemVoucherModel(
      redeemVoucher:
          json["redeemVoucher"] == null
              ? null
              : RedeemVoucher.fromJson(json["redeemVoucher"]),
    );
  }

  Map<String, dynamic> toJson() => {"redeemVoucher": redeemVoucher?.toJson()};
}

class RedeemVoucher {
  RedeemVoucher({
    required this.status,
    required this.message,
    required this.activityId,
    required this.amount,
    required this.type,
  });

  final bool? status;
  final String? message;
  final String? activityId;
  final dynamic amount;
  final String? type;

  factory RedeemVoucher.fromJson(Map<String, dynamic> json) {
    return RedeemVoucher(
      status: json["status"],
      message: json["message"],
      activityId: json["activityId"],
      amount: json["amount"],
      type: json["type"],
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "activityId": activityId,
    "amount": amount,
    "type": type,
  };
}
