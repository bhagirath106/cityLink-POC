class AutoCompletionModel {
  AutoCompletionModel({required this.suggestions, required this.warnings});

  final List<Suggestion> suggestions;
  final List<dynamic> warnings;

  factory AutoCompletionModel.fromJson(Map<String, dynamic> json) {
    return AutoCompletionModel(
      suggestions:
          json["suggestions"] == null
              ? []
              : List<Suggestion>.from(
                json["suggestions"]!.map((x) => Suggestion.fromJson(x)),
              ),
      warnings:
          json["warnings"] == null
              ? []
              : List<dynamic>.from(json["warnings"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "suggestions": suggestions.map((x) => x.toJson()).toList(),
    "warnings": warnings.map((x) => x).toList(),
  };
}

class Suggestion {
  Suggestion({
    required this.id,
    required this.name,
    required this.provider,
    required this.address,
    required this.types,
  });

  final String? id;
  final String? name;
  final String? provider;
  final String? address;
  final List<dynamic> types;

  factory Suggestion.fromJson(Map<String, dynamic> json) {
    return Suggestion(
      id: json["id"],
      name: json["name"],
      provider: json["provider"],
      address: json["address"],
      types:
          json["types"] == null
              ? []
              : List<dynamic>.from(json["types"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "provider": provider,
    "address": address,
    "types": types.map((x) => x).toList(),
  };
}
