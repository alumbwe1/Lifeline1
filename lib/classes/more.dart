class More {
  String name;
  String image;
  String location;
  String phone_number;

  More({
    required this.name,
    required this.image,
    required this.location,
    required this.phone_number,
  });

  factory More.fromJson(Map<String, dynamic> json) {
    return More(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      location: json['location'] ?? '',
      phone_number: json['phone_number'] ?? '',

    );
  }
}
