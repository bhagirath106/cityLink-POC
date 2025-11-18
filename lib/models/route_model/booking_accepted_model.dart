class BookingAcceptedModel {
  BookingAcceptedModel({
    required this.booking,
    required this.segments,
    required this.payment,
  });

  final Booking? booking;
  final List<BookingAcceptedSegment> segments;
  final Payment? payment;

  factory BookingAcceptedModel.fromJson(Map<String, dynamic> json) {
    return BookingAcceptedModel(
      booking:
          json["booking"] == null ? null : Booking.fromJson(json["booking"]),
      segments:
          json["segments"] == null
              ? []
              : List<BookingAcceptedSegment>.from(
                json["segments"]!.map(
                  (x) => BookingAcceptedSegment.fromJson(x),
                ),
              ),
      payment:
          json["payment"] == null ? null : Payment.fromJson(json["payment"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "booking": booking?.toJson(),
    "segments": segments.map((x) => x.toJson()).toList(),
    "payment": payment?.toJson(),
  };
}

class Booking {
  Booking({
    required this.id,
    required this.applicationId,
    required this.paymentMethodType,
    required this.status,
    required this.passenger,
    required this.code,
    required this.driver,
    required this.cancellation,
    required this.passengerCount,
    required this.price,
    required this.tariffs,
    required this.bookableAccessibilityOptions,
    required this.destinations,
    required this.vehicle,
    required this.websocketsEventsUrl,
    required this.region,
    required this.bookingRequest,
    required this.callableAt,
    required this.driverCallableAt,
    required this.pickup,
    required this.pickupLatestTime,
    required this.dropoffLatestTime,
    required this.detourTime,
    required this.discountOrder,
    required this.paidByWallet,
    required this.subStatus,
  });

  final String? id;
  final String? applicationId;
  final String? paymentMethodType;
  final String? status;
  final Passenger? passenger;
  final String? code;
  final Driver? driver;
  final dynamic cancellation;
  final int? passengerCount;
  final BookingPrice? price;
  final List<Tariff> tariffs;
  final List<dynamic> bookableAccessibilityOptions;
  final List<dynamic> destinations;
  final Vehicle? vehicle;
  final String? websocketsEventsUrl;
  final Region? region;
  final BookingRequest? bookingRequest;
  final List<CallableAt> callableAt;
  final List<DriverCallableAt> driverCallableAt;
  final Pickup? pickup;
  final DateTime? pickupLatestTime;
  final DateTime? dropoffLatestTime;
  final int? detourTime;
  final DiscountOrder? discountOrder;
  final dynamic paidByWallet;
  final String? subStatus;

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json["id"],
      applicationId: json["application_id"],
      paymentMethodType: json["payment_method_type"],
      status: json["status"],
      passenger:
          json["passenger"] == null
              ? null
              : Passenger.fromJson(json["passenger"]),
      code: json["code"],
      driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
      cancellation: json["cancellation"],
      passengerCount: json["passenger_count"],
      price:
          json["price"] == null ? null : BookingPrice.fromJson(json["price"]),
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
      destinations:
          json["destinations"] == null
              ? []
              : List<dynamic>.from(json["destinations"]!.map((x) => x)),
      vehicle:
          json["vehicle"] == null ? null : Vehicle.fromJson(json["vehicle"]),
      websocketsEventsUrl: json["websockets_events_url"],
      region: json["region"] == null ? null : Region.fromJson(json["region"]),
      bookingRequest:
          json["booking_request"] == null
              ? null
              : BookingRequest.fromJson(json["booking_request"]),
      callableAt:
          json["callable_at"] == null
              ? []
              : List<CallableAt>.from(
                json["callable_at"]!.map((x) => CallableAt.fromJson(x)),
              ),
      driverCallableAt:
          json["driver_callable_at"] == null
              ? []
              : List<DriverCallableAt>.from(
                json["driver_callable_at"]!.map(
                  (x) => DriverCallableAt.fromJson(x),
                ),
              ),
      pickup: json["pickup"] == null ? null : Pickup.fromJson(json["pickup"]),
      pickupLatestTime: DateTime.tryParse(json["pickup_latest_time"] ?? ""),
      dropoffLatestTime: DateTime.tryParse(json["dropoff_latest_time"] ?? ""),
      detourTime: json["detour_time"],
      discountOrder:
          json["discount_order"] == null
              ? null
              : DiscountOrder.fromJson(json["discount_order"]),
      paidByWallet: json["paid_by_wallet"],
      subStatus: json["sub_status"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "application_id": applicationId,
    "payment_method_type": paymentMethodType,
    "status": status,
    "passenger": passenger?.toJson(),
    "code": code,
    "driver": driver?.toJson(),
    "cancellation": cancellation,
    "passenger_count": passengerCount,
    "price": price?.toJson(),
    "tariffs": tariffs.map((x) => x.toJson()).toList(),
    "bookable_accessibility_options":
        bookableAccessibilityOptions.map((x) => x).toList(),
    "destinations": destinations.map((x) => x).toList(),
    "vehicle": vehicle?.toJson(),
    "websockets_events_url": websocketsEventsUrl,
    "region": region?.toJson(),
    "booking_request": bookingRequest?.toJson(),
    "callable_at": callableAt.map((x) => x.toJson()).toList(),
    "driver_callable_at": driverCallableAt.map((x) => x.toJson()).toList(),
    "pickup": pickup?.toJson(),
    "pickup_latest_time": pickupLatestTime?.toIso8601String(),
    "dropoff_latest_time": dropoffLatestTime?.toIso8601String(),
    "detour_time": detourTime,
    "discount_order": discountOrder?.toJson(),
    "paid_by_wallet": paidByWallet,
    "sub_status": subStatus,
  };
}

class BookingRequest {
  BookingRequest({
    required this.id,
    required this.at,
    required this.by,
    required this.from,
    required this.to,
  });

  final String? id;
  final DateTime? at;
  final String? by;
  final From? from;
  final From? to;

  factory BookingRequest.fromJson(Map<String, dynamic> json) {
    return BookingRequest(
      id: json["id"],
      at: DateTime.tryParse(json["at"] ?? ""),
      by: json["by"],
      from: json["from"] == null ? null : From.fromJson(json["from"]),
      to: json["to"] == null ? null : From.fromJson(json["to"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "at": at?.toIso8601String(),
    "by": by,
    "from": from?.toJson(),
    "to": to?.toJson(),
  };
}

class From {
  From({
    required this.lat,
    required this.lng,
    required this.name,
    required this.address,
  });

  final double? lat;
  final double? lng;
  final String? name;
  final String? address;

  factory From.fromJson(Map<String, dynamic> json) {
    return From(
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

class Driver {
  Driver({required this.firstName, required this.image, required this.id});

  final String? firstName;
  final String? image;
  final String? id;

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      firstName: json["first_name"],
      image: json["image"],
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "image": image,
    "id": id,
  };
}

class DriverCallableAt {
  DriverCallableAt({required this.service, required this.properties});

  final String? service;
  final DriverCallableAtProperties? properties;

  factory DriverCallableAt.fromJson(Map<String, dynamic> json) {
    return DriverCallableAt(
      service: json["service"],
      properties:
          json["properties"] == null
              ? null
              : DriverCallableAtProperties.fromJson(json["properties"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "service": service,
    "properties": properties?.toJson(),
  };
}

class DriverCallableAtProperties {
  DriverCallableAtProperties({required this.driverId});

  final String? driverId;

  factory DriverCallableAtProperties.fromJson(Map<String, dynamic> json) {
    return DriverCallableAtProperties(driverId: json["driver_id"]);
  }

  Map<String, dynamic> toJson() => {"driver_id": driverId};
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

class Pickup {
  Pickup({required this.etaUpdates});

  final List<EtaUpdate> etaUpdates;

  factory Pickup.fromJson(Map<String, dynamic> json) {
    return Pickup(
      etaUpdates:
          json["eta_updates"] == null
              ? []
              : List<EtaUpdate>.from(
                json["eta_updates"]!.map((x) => EtaUpdate.fromJson(x)),
              ),
    );
  }

  Map<String, dynamic> toJson() => {
    "eta_updates": etaUpdates.map((x) => x.toJson()).toList(),
  };
}

class EtaUpdate {
  EtaUpdate({required this.createdAt, required this.estimatedTime});

  final DateTime? createdAt;
  final DateTime? estimatedTime;

  factory EtaUpdate.fromJson(Map<String, dynamic> json) {
    return EtaUpdate(
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      estimatedTime: DateTime.tryParse(json["estimated_time"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "created_at": createdAt?.toIso8601String(),
    "estimated_time": estimatedTime?.toIso8601String(),
  };
}

class BookingPrice {
  BookingPrice({required this.amount, required this.currency});

  final int? amount;
  final String? currency;

  factory BookingPrice.fromJson(Map<String, dynamic> json) {
    return BookingPrice(amount: json["amount"], currency: json["currency"]);
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
  final BookingPrice? price;
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
          json["price"] == null ? null : BookingPrice.fromJson(json["price"]),
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

class Vehicle {
  Vehicle({
    required this.id,
    required this.location,
    required this.manufacturer,
    required this.model,
    required this.label,
    required this.licensePlate,
  });

  final String? id;
  final From? location;
  final String? manufacturer;
  final String? model;
  final String? label;
  final String? licensePlate;

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json["id"],
      location:
          json["location"] == null ? null : From.fromJson(json["location"]),
      manufacturer: json["manufacturer"],
      model: json["model"],
      label: json["label"],
      licensePlate: json["license_plate"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "location": location?.toJson(),
    "manufacturer": manufacturer,
    "model": model,
    "label": label,
    "license_plate": licensePlate,
  };
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
  final BookingPrice? price;
  final PaymentActions? paymentActions;
  final PaymentMethod? paymentMethod;

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json["id"],
      userId: json["user_id"],
      reference: json["reference"],
      referenceType: json["reference_type"],
      price:
          json["price"] == null ? null : BookingPrice.fromJson(json["price"]),
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

class BookingAcceptedSegment {
  BookingAcceptedSegment({
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
  final dynamic distance;
  final String? name;
  final String? shortName;
  final String? color;
  final List<Stop> stops;

  factory BookingAcceptedSegment.fromJson(Map<String, dynamic> json) {
    return BookingAcceptedSegment(
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

  final From? location;
  final DateTime? scheduledTime;
  final DateTime? estimatedTime;
  final DateTime? latestTime;
  final Task? task;

  factory Stop.fromJson(Map<String, dynamic> json) {
    return Stop(
      location:
          json["location"] == null ? null : From.fromJson(json["location"]),
      scheduledTime: DateTime.tryParse(json["scheduled_time"] ?? ""),
      estimatedTime: DateTime.tryParse(json["estimated_time"] ?? ""),
      latestTime: DateTime.tryParse(json["latest_time"] ?? ""),
      task: json["task"] == null ? null : Task.fromJson(json["task"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "location": location?.toJson(),
    "scheduled_time": scheduledTime?.toIso8601String(),
    "estimated_time": estimatedTime?.toIso8601String(),
    "latest_time": latestTime?.toIso8601String(),
    "task": task?.toJson(),
  };
}

class Task {
  Task({required this.status});

  final String? status;

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(status: json["status"]);
  }

  Map<String, dynamic> toJson() => {"status": status};
}
