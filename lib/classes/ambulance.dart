class Ambulance {
  String name;
  String image;
  String location;
  String phone_number;

  Ambulance({
    required this.name,
    required this.image,
    required this.location,
    required this.phone_number,
  });

  factory Ambulance.fromJson(Map<String, dynamic> json) {
    return Ambulance(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      location: json['location'] ?? '',
      phone_number: json['phone_number'] ?? '',

    );
  }
}
