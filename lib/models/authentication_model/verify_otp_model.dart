class VerifyOtpModel {
  VerifyOtpModel({
    required this.to,
    required this.channel,
    required this.status,
    required this.valid,
  });

  final String? to;
  final String? channel;
  final String? status;
  final bool? valid;

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) {
    return VerifyOtpModel(
      to: json["to"],
      channel: json["channel"],
      status: json["status"],
      valid: json["valid"],
    );
  }

  Map<String, dynamic> toJson() => {
    "to": to,
    "channel": channel,
    "status": status,
    "valid": valid,
  };
}
