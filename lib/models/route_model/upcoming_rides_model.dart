class UpComingRidesModel {
  UpComingRidesModel({required this.upcomingRides});

  final List<UpcomingRideElement> upcomingRides;

  factory UpComingRidesModel.fromJson(Map<String, dynamic> json) {
    return UpComingRidesModel(
      upcomingRides:
          json["upcoming_rides"] == null
              ? []
              : List<UpcomingRideElement>.from(
                json["upcoming_rides"]!.map(
                  (x) => UpcomingRideElement.fromJson(x),
                ),
              ),
    );
  }

  Map<String, dynamic> toJson() => {
    "upcoming_rides": upcomingRides.map((x) => x.toJson()).toList(),
  };
}

class UpcomingRideElement {
  UpcomingRideElement({required this.upcomingRide});

  final UpcomingRideUpcomingRide? upcomingRide;

  factory UpcomingRideElement.fromJson(Map<String, dynamic> json) {
    return UpcomingRideElement(
      upcomingRide:
          json["upcoming_ride"] == null
              ? null
              : UpcomingRideUpcomingRide.fromJson(json["upcoming_ride"]),
    );
  }

  Map<String, dynamic> toJson() => {"upcoming_ride": upcomingRide?.toJson()};
}

class UpcomingRideUpcomingRide {
  UpcomingRideUpcomingRide({
    required this.bookingRequestId,
    required this.bookingId,
    required this.price,
    required this.status,
    required this.processingTime,
    required this.locations,
  });

  final String? bookingRequestId;
  final String? bookingId;
  final Price? price;
  final String? status;
  final DateTime? processingTime;
  final Locations? locations;

  factory UpcomingRideUpcomingRide.fromJson(Map<String, dynamic> json) {
    return UpcomingRideUpcomingRide(
      bookingRequestId: json["booking_request_id"],
      bookingId: json["booking_id"],
      price: json["price"] == null ? null : Price.fromJson(json["price"]),
      status: json["status"],
      processingTime: DateTime.tryParse(json["processing_time"] ?? ""),
      locations:
          json["locations"] == null
              ? null
              : Locations.fromJson(json["locations"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "booking_request_id": bookingRequestId,
    "booking_id": bookingId,
    "price": price?.toJson(),
    "status": status,
    "processing_time": processingTime?.toIso8601String(),
    "locations": locations?.toJson(),
  };
}

class Locations {
  Locations({
    required this.origin,
    required this.pickup,
    required this.dropoff,
    required this.destination,
  });

  final Destination? origin;
  final Destination? pickup;
  final Destination? dropoff;
  final Destination? destination;

  factory Locations.fromJson(Map<String, dynamic> json) {
    return Locations(
      origin:
          json["origin"] == null ? null : Destination.fromJson(json["origin"]),
      pickup:
          json["pickup"] == null ? null : Destination.fromJson(json["pickup"]),
      dropoff:
          json["dropoff"] == null
              ? null
              : Destination.fromJson(json["dropoff"]),
      destination:
          json["destination"] == null
              ? null
              : Destination.fromJson(json["destination"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "origin": origin?.toJson(),
    "pickup": pickup?.toJson(),
    "dropoff": dropoff?.toJson(),
    "destination": destination?.toJson(),
  };
}

class Destination {
  Destination({required this.address, required this.estimatedTime});

  final String? address;
  final DateTime? estimatedTime;

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      address: json["address"],
      estimatedTime: DateTime.tryParse(json["estimated_time"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "address": address,
    "estimated_time": estimatedTime?.toIso8601String(),
  };
}

class Price {
  Price({required this.amount, required this.currency});

  final int? amount;
  final String? currency;

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(amount: json["amount"], currency: json["currency"]);
  }

  Map<String, dynamic> toJson() => {"amount": amount, "currency": currency};
}
