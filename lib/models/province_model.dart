class Province {
  List<Provinces>? provinces;

  Province({this.provinces});

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      provinces: json['provinces'] != null
          ? (json['provinces'] as List)
              .map((i) => Provinces.fromJson(i))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'provinces':
          provinces != null ? provinces!.map((v) => v.toJson()).toList() : null,
    };
  }
}

class Provinces {
  String? id;
  String? name;

  Provinces({this.id, this.name});

  factory Provinces.fromJson(Map<String, dynamic> json) {
    return Provinces(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
