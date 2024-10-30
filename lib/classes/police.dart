class Police {
  String name;
  String image;
  String location;
  String phone_number;

  Police({
    required this.name,
    required this.image,
    required this.location,
    required this.phone_number,
  });

  factory Police.fromJson(Map<String, dynamic> json) {
    return Police(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      location: json['location'] ?? '',
      phone_number: json['phone_number'] ?? '',
    );
  }
}
