class BookingRequestModel {
  BookingRequestModel({
    required this.bookingRequest,
    required this.regionId,
    required this.segments,
    required this.bookingRequestModelOperator,
    required this.payment,
  });

  final BookingRequest? bookingRequest;
  final String? regionId;
  final List<Segment> segments;
  final Operator? bookingRequestModelOperator;
  final Payment? payment;

  factory BookingRequestModel.fromJson(Map<String, dynamic> json) {
    return BookingRequestModel(
      bookingRequest:
          json["booking_request"] == null
              ? null
              : BookingRequest.fromJson(json["booking_request"]),
      regionId: json["region_id"],
      segments:
          json["segments"] == null
              ? []
              : List<Segment>.from(
                json["segments"]!.map((x) => Segment.fromJson(x)),
              ),
      bookingRequestModelOperator:
          json["operator"] == null ? null : Operator.fromJson(json["operator"]),
      payment:
          json["payment"] == null ? null : Payment.fromJson(json["payment"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "booking_request": bookingRequest?.toJson(),
    "region_id": regionId,
    "segments": segments.map((x) => x.toJson()).toList(),
    "operator": bookingRequestModelOperator?.toJson(),
    "payment": payment?.toJson(),
  };
}

class BookingRequest {
  BookingRequest({
    required this.id,
    required this.speculative,
    required this.passenger,
    required this.passengerCount,
    required this.at,
    required this.by,
    required this.reservationExpiresIn,
    required this.price,
    required this.tariffs,
    required this.bookableAccessibilityOptions,
    required this.status,
    required this.createdAt,
    required this.processedAt,
    required this.cancelledAt,
    required this.processingTime,
    required this.bookingId,
    required this.callableAt,
    required this.searchId,
    required this.cancellation,
    required this.region,
    required this.discountOrder,
  });

  final String? id;
  final bool? speculative;
  final Passenger? passenger;
  final int? passengerCount;
  final DateTime? at;
  final String? by;
  final int? reservationExpiresIn;
  final BookingRequestPrice? price;
  final List<Tariff> tariffs;
  final List<dynamic> bookableAccessibilityOptions;
  final String? status;
  final DateTime? createdAt;
  final dynamic processedAt;
  final dynamic cancelledAt;
  final DateTime? processingTime;
  final dynamic bookingId;
  final List<CallableAt> callableAt;
  final String? searchId;
  final dynamic cancellation;
  final Region? region;
  final DiscountOrder? discountOrder;

  factory BookingRequest.fromJson(Map<String, dynamic> json) {
    return BookingRequest(
      id: json["id"],
      speculative: json["speculative"],
      passenger:
          json["passenger"] == null
              ? null
              : Passenger.fromJson(json["passenger"]),
      passengerCount: json["passenger_count"],
      at: DateTime.tryParse(json["at"] ?? ""),
      by: json["by"],
      reservationExpiresIn: json["reservation_expires_in"],
      price:
          json["price"] == null
              ? null
              : BookingRequestPrice.fromJson(json["price"]),
      tariffs:
          json["tariffs"] == null
              ? []
              : List<Tariff>.from(
                json["tariffs"]!.map((x) => Tariff.fromJson(x)),
              ),
      bookableAccessibilityOptions:
          json["bookable_accessibility_options"] == null
              ? []
              : List<dynamic>.from(
                json["bookable_accessibility_options"]!.map((x) => x),
              ),
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      processedAt: json["processed_at"],
      cancelledAt: json["cancelled_at"],
      processingTime: DateTime.tryParse(json["processing_time"] ?? ""),
      bookingId: json["booking_id"],
      callableAt:
          json["callable_at"] == null
              ? []
              : List<CallableAt>.from(
                json["callable_at"]!.map((x) => CallableAt.fromJson(x)),
              ),
      searchId: json["search_id"],
      cancellation: json["cancellation"],
      region: json["region"] == null ? null : Region.fromJson(json["region"]),
      discountOrder:
          json["discount_order"] == null
              ? null
              : DiscountOrder.fromJson(json["discount_order"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "speculative": speculative,
    "passenger": passenger?.toJson(),
    "passenger_count": passengerCount,
    "at": at?.toIso8601String(),
    "by": by,
    "reservation_expires_in": reservationExpiresIn,
    "price": price?.toJson(),
    "tariffs": tariffs.map((x) => x.toJson()).toList(),
    "bookable_accessibility_options":
        bookableAccessibilityOptions.map((x) => x).toList(),
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "processed_at": processedAt,
    "cancelled_at": cancelledAt,
    "processing_time": processingTime?.toIso8601String(),
    "booking_id": bookingId,
    "callable_at": callableAt.map((x) => x.toJson()).toList(),
    "search_id": searchId,
    "cancellation": cancellation,
    "region": region?.toJson(),
    "discount_order": discountOrder?.toJson(),
  };
}

class CallableAt {
  CallableAt({required this.service, required this.properties});

  final String? service;
  final CallableAtProperties? properties;

  factory CallableAt.fromJson(Map<String, dynamic> json) {
    return CallableAt(
      service: json["service"],
      properties:
          json["properties"] == null
              ? null
              : CallableAtProperties.fromJson(json["properties"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "service": service,
    "properties": properties?.toJson(),
  };
}

class CallableAtProperties {
  CallableAtProperties({required this.clientId});

  final String? clientId;

  factory CallableAtProperties.fromJson(Map<String, dynamic> json) {
    return CallableAtProperties(clientId: json["client_id"]);
  }

  Map<String, dynamic> toJson() => {"client_id": clientId};
}

class DiscountOrder {
  DiscountOrder({
    required this.resourceId,
    required this.customerReference,
    required this.orderReference,
    required this.price,
    required this.discountedPrice,
    required this.discountDescription,
  });

  final String? resourceId;
  final String? customerReference;
  final String? orderReference;
  final DiscountOrderPrice? price;
  final DiscountedPrice? discountedPrice;
  final String? discountDescription;

  factory DiscountOrder.fromJson(Map<String, dynamic> json) {
    return DiscountOrder(
      resourceId: json["resource_id"],
      customerReference: json["customer_reference"],
      orderReference: json["order_reference"],
      price:
          json["price"] == null
              ? null
              : DiscountOrderPrice.fromJson(json["price"]),
      discountedPrice:
          json["discounted_price"] == null
              ? null
              : DiscountedPrice.fromJson(json["discounted_price"]),
      discountDescription: json["discount_description"],
    );
  }

  Map<String, dynamic> toJson() => {
    "resource_id": resourceId,
    "customer_reference": customerReference,
    "order_reference": orderReference,
    "price": price?.toJson(),
    "discounted_price": discountedPrice?.toJson(),
    "discount_description": discountDescription,
  };
}

class DiscountedPrice {
  DiscountedPrice({required this.amount, required this.transactionReceipt});

  final int? amount;
  final TransactionReceipt? transactionReceipt;

  factory DiscountedPrice.fromJson(Map<String, dynamic> json) {
    return DiscountedPrice(
      amount: json["amount"],
      transactionReceipt:
          json["transaction_receipt"] == null
              ? null
              : TransactionReceipt.fromJson(json["transaction_receipt"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "transaction_receipt": transactionReceipt?.toJson(),
  };
}

class TransactionReceipt {
  TransactionReceipt({required this.credits});

  final Credits? credits;

  factory TransactionReceipt.fromJson(Map<String, dynamic> json) {
    return TransactionReceipt(
      credits:
          json["credits"] == null ? null : Credits.fromJson(json["credits"]),
    );
  }

  Map<String, dynamic> toJson() => {"credits": credits?.toJson()};
}

class Credits {
  Credits({required this.promoCodes, required this.referrals});

  final int? promoCodes;
  final int? referrals;

  factory Credits.fromJson(Map<String, dynamic> json) {
    return Credits(
      promoCodes: json["promo_codes"],
      referrals: json["referrals"],
    );
  }

  Map<String, dynamic> toJson() => {
    "promo_codes": promoCodes,
    "referrals": referrals,
  };
}

class DiscountOrderPrice {
  DiscountOrderPrice({required this.amount});

  final int? amount;

  factory DiscountOrderPrice.fromJson(Map<String, dynamic> json) {
    return DiscountOrderPrice(amount: json["amount"]);
  }

  Map<String, dynamic> toJson() => {"amount": amount};
}

class Passenger {
  Passenger({
    required this.reference,
    required this.firstName,
    required this.lastName,
  });

  final String? reference;
  final String? firstName;
  final String? lastName;

  factory Passenger.fromJson(Map<String, dynamic> json) {
    return Passenger(
      reference: json["reference"],
      firstName: json["first_name"],
      lastName: json["last_name"],
    );
  }

  Map<String, dynamic> toJson() => {
    "reference": reference,
    "first_name": firstName,
    "last_name": lastName,
  };
}

class BookingRequestPrice {
  BookingRequestPrice({required this.amount, required this.currency});

  final int? amount;
  final String? currency;

  factory BookingRequestPrice.fromJson(Map<String, dynamic> json) {
    return BookingRequestPrice(
      amount: json["amount"],
      currency: json["currency"],
    );
  }

  Map<String, dynamic> toJson() => {"amount": amount, "currency": currency};
}

class Region {
  Region({required this.id, required this.timezone});

  final String? id;
  final String? timezone;

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(id: json["id"], timezone: json["timezone"]);
  }

  Map<String, dynamic> toJson() => {"id": id, "timezone": timezone};
}

class Tariff {
  Tariff({
    required this.id,
    required this.name,
    required this.description,
    required this.disclaimer,
    required this.passengerCount,
    required this.price,
    required this.categoryId,
    required this.code,
    required this.tickets,
  });

  final String? id;
  final String? name;
  final String? description;
  final String? disclaimer;
  final int? passengerCount;
  final BookingRequestPrice? price;
  final String? categoryId;
  final String? code;
  final List<dynamic> tickets;

  factory Tariff.fromJson(Map<String, dynamic> json) {
    return Tariff(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      disclaimer: json["disclaimer"],
      passengerCount: json["passenger_count"],
      price:
          json["price"] == null
              ? null
              : BookingRequestPrice.fromJson(json["price"]),
      categoryId: json["category_id"],
      code: json["code"],
      tickets:
          json["tickets"] == null
              ? []
              : List<dynamic>.from(json["tickets"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "disclaimer": disclaimer,
    "passenger_count": passengerCount,
    "price": price?.toJson(),
    "category_id": categoryId,
    "code": code,
    "tickets": tickets.map((x) => x).toList(),
  };
}

class Operator {
  Operator({required this.name});

  final String? name;

  factory Operator.fromJson(Map<String, dynamic> json) {
    return Operator(name: json["name"]);
  }

  Map<String, dynamic> toJson() => {"name": name};
}

class Payment {
  Payment({
    required this.id,
    required this.userId,
    required this.reference,
    required this.referenceType,
    required this.price,
    required this.paymentActions,
    required this.paymentMethod,
  });

  final String? id;
  final String? userId;
  final String? reference;
  final String? referenceType;
  final BookingRequestPrice? price;
  final PaymentActions? paymentActions;
  final PaymentMethod? paymentMethod;

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json["id"],
      userId: json["user_id"],
      reference: json["reference"],
      referenceType: json["reference_type"],
      price:
          json["price"] == null
              ? null
              : BookingRequestPrice.fromJson(json["price"]),
      paymentActions:
          json["payment_actions"] == null
              ? null
              : PaymentActions.fromJson(json["payment_actions"]),
      paymentMethod:
          json["payment_method"] == null
              ? null
              : PaymentMethod.fromJson(json["payment_method"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "reference": reference,
    "reference_type": referenceType,
    "price": price?.toJson(),
    "payment_actions": paymentActions?.toJson(),
    "payment_method": paymentMethod?.toJson(),
  };
}

class PaymentActions {
  PaymentActions({
    required this.preAuthorization,
    required this.authorization,
    required this.settlement,
    required this.voidance,
    required this.refund,
  });

  final Authorization? preAuthorization;
  final Authorization? authorization;
  final Authorization? settlement;
  final Authorization? voidance;
  final Authorization? refund;

  factory PaymentActions.fromJson(Map<String, dynamic> json) {
    return PaymentActions(
      preAuthorization:
          json["pre_authorization"] == null
              ? null
              : Authorization.fromJson(json["pre_authorization"]),
      authorization:
          json["authorization"] == null
              ? null
              : Authorization.fromJson(json["authorization"]),
      settlement:
          json["settlement"] == null
              ? null
              : Authorization.fromJson(json["settlement"]),
      voidance:
          json["voidance"] == null
              ? null
              : Authorization.fromJson(json["voidance"]),
      refund:
          json["refund"] == null
              ? null
              : Authorization.fromJson(json["refund"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "pre_authorization": preAuthorization?.toJson(),
    "authorization": authorization?.toJson(),
    "settlement": settlement?.toJson(),
    "voidance": voidance?.toJson(),
    "refund": refund?.toJson(),
  };
}

class Authorization {
  Authorization({required this.attemptedAt, required this.succeeded});

  final DateTime? attemptedAt;
  final bool? succeeded;

  factory Authorization.fromJson(Map<String, dynamic> json) {
    return Authorization(
      attemptedAt: DateTime.tryParse(json["attempted_at"] ?? ""),
      succeeded: json["succeeded"],
    );
  }

  Map<String, dynamic> toJson() => {
    "attempted_at": attemptedAt?.toIso8601String(),
    "succeeded": succeeded,
  };
}

class PaymentMethod {
  PaymentMethod({
    required this.type,
    required this.processor,
    required this.properties,
  });

  final String? type;
  final String? processor;
  final PaymentMethodProperties? properties;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      type: json["type"],
      processor: json["processor"],
      properties:
          json["properties"] == null
              ? null
              : PaymentMethodProperties.fromJson(json["properties"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "type": type,
    "processor": processor,
    "properties": properties?.toJson(),
  };
}

class PaymentMethodProperties {
  PaymentMethodProperties({
    required this.minBalance,
    required this.minRecharge,
  });

  final dynamic minBalance;
  final dynamic minRecharge;

  factory PaymentMethodProperties.fromJson(Map<String, dynamic> json) {
    return PaymentMethodProperties(
      minBalance: json["min_balance"],
      minRecharge: json["min_recharge"],
    );
  }

  Map<String, dynamic> toJson() => {
    "min_balance": minBalance,
    "min_recharge": minRecharge,
  };
}

class Segment {
  Segment({
    required this.type,
    required this.polyline,
    required this.distance,
    required this.name,
    required this.shortName,
    required this.color,
    required this.stops,
  });

  final String? type;
  final String? polyline;
  final double? distance;
  final String? name;
  final String? shortName;
  final String? color;
  final List<Stop> stops;

  factory Segment.fromJson(Map<String, dynamic> json) {
    return Segment(
      type: json["type"],
      polyline: json["polyline"],
      distance: json["distance"],
      name: json["name"],
      shortName: json["short_name"],
      color: json["color"],
      stops:
          json["stops"] == null
              ? []
              : List<Stop>.from(json["stops"]!.map((x) => Stop.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "type": type,
    "polyline": polyline,
    "distance": distance,
    "name": name,
    "short_name": shortName,
    "color": color,
    "stops": stops.map((x) => x.toJson()).toList(),
  };
}

class Stop {
  Stop({
    required this.location,
    required this.scheduledTime,
    required this.estimatedTime,
    required this.latestTime,
    required this.task,
  });

  final Location? location;
  final DateTime? scheduledTime;
  final DateTime? estimatedTime;
  final DateTime? latestTime;
  final dynamic task;

  factory Stop.fromJson(Map<String, dynamic> json) {
    return Stop(
      location:
          json["location"] == null ? null : Location.fromJson(json["location"]),
      scheduledTime: DateTime.tryParse(json["scheduled_time"] ?? ""),
      estimatedTime: DateTime.tryParse(json["estimated_time"] ?? ""),
      latestTime: DateTime.tryParse(json["latest_time"] ?? ""),
      task: json["task"],
    );
  }

  Map<String, dynamic> toJson() => {
    "location": location?.toJson(),
    "scheduled_time": scheduledTime?.toIso8601String(),
    "estimated_time": estimatedTime?.toIso8601String(),
    "latest_time": latestTime?.toIso8601String(),
    "task": task,
  };
}

class Location {
  Location({
    required this.lat,
    required this.lng,
    required this.name,
    required this.address,
  });

  final double? lat;
  final double? lng;
  final String? name;
  final String? address;

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: json["lat"],
      lng: json["lng"],
      name: json["name"],
      address: json["address"],
    );
  }

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
    "name": name,
    "address": address,
  };
}
