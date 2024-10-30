class FireBrigade {
  String name;
  String image;
  String location;
  String phone_number;

  FireBrigade({
    required this.name,
    required this.image,
    required this.location,
    required this.phone_number,
  });

  factory FireBrigade.fromJson(Map<String, dynamic> json) {
    return FireBrigade(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      location: json['location'] ?? '',
      phone_number: json['phone_number'] ?? '',

    );
  }
}
