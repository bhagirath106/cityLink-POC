class GetRouteDataModel {
  GetRouteDataModel({required this.routes});

  final List<Route> routes;

  factory GetRouteDataModel.fromJson(Map<String, dynamic> json) {
    return GetRouteDataModel(
      routes:
          json["routes"] == null
              ? []
              : List<Route>.from(json["routes"]!.map((x) => Route.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "routes": routes.map((x) => x.toJson()).toList(),
  };
}

class Route {
  Route({
    required this.id,
    required this.name,
    required this.type,
    required this.subtype,
    required this.segments,
    required this.fares,
    required this.discountOrder,
    required this.price,
    required this.errors,
    required this.properties,
    required this.links,
  });

  final String? id;
  final String? name;
  final String? type;
  final dynamic subtype;
  final List<Segment> segments;
  final List<Fare> fares;
  final DiscountOrder? discountOrder;
  final Price? price;
  final List<Error> errors;
  final Properties? properties;
  final List<dynamic> links;

  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(
      id: json["id"],
      name: json["name"],
      type: json["type"],
      subtype: json["subtype"],
      segments:
          json["segments"] == null
              ? []
              : List<Segment>.from(
                json["segments"]!.map((x) => Segment.fromJson(x)),
              ),
      fares:
          json["fares"] == null
              ? []
              : List<Fare>.from(json["fares"]!.map((x) => Fare.fromJson(x))),
      discountOrder:
          json["discount_order"] == null
              ? null
              : DiscountOrder.fromJson(json["discount_order"]),
      price: json["price"] == null ? null : Price.fromJson(json["price"]),
      errors:
          json["errors"] == null
              ? []
              : List<Error>.from(json["errors"]!.map((x) => Error.fromJson(x))),
      properties:
          json["properties"] == null
              ? null
              : Properties.fromJson(json["properties"]),
      links:
          json["links"] == null
              ? []
              : List<dynamic>.from(json["links"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "subtype": subtype,
    "segments": segments.map((x) => x.toJson()).toList(),
    "fares": fares.map((x) => x.toJson()).toList(),
    "discount_order": discountOrder?.toJson(),
    "price": price?.toJson(),
    "errors": errors.map((x) => x.toJson()).toList(),
    "properties": properties?.toJson(),
    "links": links.map((x) => x).toList(),
  };
}

class DiscountOrder {
  DiscountOrder({
    required this.resourceId,
    required this.description,
    required this.price,
    required this.discountedPrice,
    required this.voucherDescription,
  });

  final dynamic resourceId;
  final dynamic description;
  final dynamic price;
  final dynamic discountedPrice;
  final dynamic voucherDescription;

  factory DiscountOrder.fromJson(Map<String, dynamic> json) {
    return DiscountOrder(
      resourceId: json["resource_id"],
      description: json["description"],
      price: json["price"],
      discountedPrice: json["discounted_price"],
      voucherDescription: json["voucher_description"],
    );
  }

  Map<String, dynamic> toJson() => {
    "resource_id": resourceId,
    "description": description,
    "price": price,
    "discounted_price": discountedPrice,
    "voucher_description": voucherDescription,
  };
}

class Error {
  Error({
    required this.code,
    required this.message,
    required this.details,
    required this.userFriendly,
  });

  final String? code;
  final String? message;
  final String? details;
  final UserFriendly? userFriendly;

  factory Error.fromJson(Map<String, dynamic> json) {
    return Error(
      code: json["code"],
      message: json["message"],
      details: json["details"],
      userFriendly:
          json["user_friendly"] == null
              ? null
              : UserFriendly.fromJson(json["user_friendly"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "details": details,
    "user_friendly": userFriendly?.toJson(),
  };
}

class UserFriendly {
  UserFriendly({required this.title, required this.description});

  final String? title;
  final String? description;

  factory UserFriendly.fromJson(Map<String, dynamic> json) {
    return UserFriendly(title: json["title"], description: json["description"]);
  }

  Map<String, dynamic> toJson() => {"title": title, "description": description};
}

class Fare {
  Fare({required this.name, required this.description, required this.price});

  final dynamic name;
  final String? description;
  final Price? price;

  factory Fare.fromJson(Map<String, dynamic> json) {
    return Fare(
      name: json["name"],
      description: json["description"],
      price: json["price"] == null ? null : Price.fromJson(json["price"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "price": price?.toJson(),
  };
}

class Price {
  Price({
    required this.amount,
    required this.currency,
    required this.estimated,
  });

  final int? amount;
  final String? currency;
  final bool? estimated;

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      amount: json["amount"],
      currency: json["currency"],
      estimated: json["estimated"],
    );
  }

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "currency": currency,
    "estimated": estimated,
  };
}

class Properties {
  Properties({
    required this.type,
    required this.selectedTariffs,
    required this.bookableAccessibilityOptions,
    required this.regionId,
    required this.bookingObject,
    required this.speculative,
    required this.at,
    required this.by,
    required this.processingTime,
  });

  final String? type;
  final List<SelectedTariff> selectedTariffs;
  final List<dynamic> bookableAccessibilityOptions;
  final String? regionId;
  final BookingObject? bookingObject;
  final bool? speculative;
  final DateTime? at;
  final String? by;
  final DateTime? processingTime;

  factory Properties.fromJson(Map<String, dynamic> json) {
    return Properties(
      type: json["type"],
      selectedTariffs:
          json["selected_tariffs"] == null
              ? []
              : List<SelectedTariff>.from(
                json["selected_tariffs"]!.map(
                  (x) => SelectedTariff.fromJson(x),
                ),
              ),
      bookableAccessibilityOptions:
          json["bookable_accessibility_options"] == null
              ? []
              : List<dynamic>.from(
                json["bookable_accessibility_options"]!.map((x) => x),
              ),
      regionId: json["region_id"],
      bookingObject:
          json["booking_object"] == null
              ? null
              : BookingObject.fromJson(json["booking_object"]),
      speculative: json["speculative"],
      at: DateTime.tryParse(json["at"] ?? ""),
      by: json["by"],
      processingTime: DateTime.tryParse(json["processing_time"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "type": type,
    "selected_tariffs": selectedTariffs.map((x) => x.toJson()).toList(),
    "bookable_accessibility_options":
        bookableAccessibilityOptions.map((x) => x).toList(),
    "region_id": regionId,
    "booking_object": bookingObject?.toJson(),
    "speculative": speculative,
    "at": at?.toIso8601String(),
    "by": by,
    "processing_time": processingTime?.toIso8601String(),
  };
}

class BookingObject {
  BookingObject({
    required this.from,
    required this.to,
    required this.tariffs,
    required this.by,
    required this.bookableAccessibilityOptions,
  });

  final From? from;
  final From? to;
  final Tariffs? tariffs;
  final String? by;
  final BookableAccessibilityOptions? bookableAccessibilityOptions;

  factory BookingObject.fromJson(Map<String, dynamic> json) {
    return BookingObject(
      from: json["from"] == null ? null : From.fromJson(json["from"]),
      to: json["to"] == null ? null : From.fromJson(json["to"]),
      tariffs:
          json["tariffs"] == null ? null : Tariffs.fromJson(json["tariffs"]),
      by: json["by"],
      bookableAccessibilityOptions:
          json["bookable_accessibility_options"] == null
              ? null
              : BookableAccessibilityOptions.fromJson(
                json["bookable_accessibility_options"],
              ),
    );
  }

  Map<String, dynamic> toJson() => {
    "from": from?.toJson(),
    "to": to?.toJson(),
    "tariffs": tariffs?.toJson(),
    "by": by,
    "bookable_accessibility_options": bookableAccessibilityOptions?.toJson(),
  };
}

class BookableAccessibilityOptions {
  BookableAccessibilityOptions({required this.json});
  final Map<String, dynamic> json;

  factory BookableAccessibilityOptions.fromJson(Map<String, dynamic> json) {
    return BookableAccessibilityOptions(json: json);
  }

  Map<String, dynamic> toJson() => {};
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

class Tariffs {
  Tariffs({required this.the7B2E50E2298B449B8Ae18Ea629Dce83C});

  final int? the7B2E50E2298B449B8Ae18Ea629Dce83C;

  factory Tariffs.fromJson(Map<String, dynamic> json) {
    return Tariffs(
      the7B2E50E2298B449B8Ae18Ea629Dce83C:
          json["7b2e50e2-298b-449b-8ae1-8ea629dce83c"],
    );
  }

  Map<String, dynamic> toJson() => {
    "7b2e50e2-298b-449b-8ae1-8ea629dce83c": the7B2E50E2298B449B8Ae18Ea629Dce83C,
  };
}

class SelectedTariff {
  SelectedTariff({
    required this.id,
    required this.name,
    required this.description,
    required this.disclaimer,
    required this.passengerCount,
    required this.categoryId,
    required this.price,
    required this.tickets,
  });

  final String? id;
  final String? name;
  final String? description;
  final String? disclaimer;
  final int? passengerCount;
  final String? categoryId;
  final Price? price;
  final List<dynamic> tickets;

  factory SelectedTariff.fromJson(Map<String, dynamic> json) {
    return SelectedTariff(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      disclaimer: json["disclaimer"],
      passengerCount: json["passenger_count"],
      categoryId: json["category_id"],
      price: json["price"] == null ? null : Price.fromJson(json["price"]),
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
    "category_id": categoryId,
    "price": price?.toJson(),
    "tickets": tickets.map((x) => x).toList(),
  };
}

class Segment {
  Segment({
    required this.type,
    required this.subtype,
    required this.name,
    required this.shortName,
    required this.description,
    required this.color,
    required this.polyline,
    required this.stops,
    required this.operators,
    required this.properties,
  });

  final String? type;
  final dynamic subtype;
  final String? name;
  final String? shortName;
  final dynamic description;
  final String? color;
  final String? polyline;
  final List<Stop> stops;
  final List<dynamic> operators;
  final dynamic properties;

  factory Segment.fromJson(Map<String, dynamic> json) {
    return Segment(
      type: json["type"],
      subtype: json["subtype"],
      name: json["name"],
      shortName: json["short_name"],
      description: json["description"],
      color: json["color"],
      polyline: json["polyline"],
      stops:
          json["stops"] == null
              ? []
              : List<Stop>.from(json["stops"]!.map((x) => Stop.fromJson(x))),
      operators:
          json["operators"] == null
              ? []
              : List<dynamic>.from(json["operators"]!.map((x) => x)),
      properties: json["properties"],
    );
  }

  Map<String, dynamic> toJson() => {
    "type": type,
    "subtype": subtype,
    "name": name,
    "short_name": shortName,
    "description": description,
    "color": color,
    "polyline": polyline,
    "stops": stops.map((x) => x.toJson()).toList(),
    "operators": operators.map((x) => x).toList(),
    "properties": properties,
  };
}

class Stop {
  Stop({
    required this.location,
    required this.scheduledTime,
    required this.estimatedTime,
    required this.latestTime,
    required this.properties,
  });

  final From? location;
  final DateTime? scheduledTime;
  final DateTime? estimatedTime;
  final DateTime? latestTime;
  final dynamic properties;

  factory Stop.fromJson(Map<String, dynamic> json) {
    return Stop(
      location:
          json["location"] == null ? null : From.fromJson(json["location"]),
      scheduledTime: DateTime.tryParse(json["scheduled_time"] ?? ""),
      estimatedTime: DateTime.tryParse(json["estimated_time"] ?? ""),
      latestTime: DateTime.tryParse(json["latest_time"] ?? ""),
      properties: json["properties"],
    );
  }

  Map<String, dynamic> toJson() => {
    "location": location?.toJson(),
    "scheduled_time": scheduledTime?.toIso8601String(),
    "estimated_time": estimatedTime?.toIso8601String(),
    "latest_time": latestTime?.toIso8601String(),
    "properties": properties,
  };
}
