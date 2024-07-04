class Hospital {
  int? status;
  List<Hospitals>? hospitals;

  Hospital({this.status, this.hospitals});

  Hospital.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['hospitals'] != null) {
      hospitals = <Hospitals>[];
      json['hospitals'].forEach((v) {
        hospitals!.add(new Hospitals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.hospitals != null) {
      data['hospitals'] = this.hospitals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hospitals {
  String? id;
  String? name;
  String? address;
  String? phone;
  int? queue;
  int? bedAvailability;
  String? info;

  Hospitals(
      {this.id,
      this.name,
      this.address,
      this.phone,
      this.queue,
      this.bedAvailability,
      this.info});

  Hospitals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    phone = json['phone'];
    queue = json['queue'];
    bedAvailability = json['bed_availability'];
    info = json['info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['queue'] = this.queue;
    data['bed_availability'] = this.bedAvailability;
    data['info'] = this.info;
    return data;
  }
}
