class AdultChildCare {
  String name;
  String image;
  String location;
  String phone_number;

  AdultChildCare({
    required this.name,
    required this.image,
    required this.location,
    required this.phone_number,
  });

  factory AdultChildCare.fromJson(Map<String, dynamic> json) {
    return AdultChildCare(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      location: json['location'] ?? '',
      phone_number: json['phone_number'] ?? '',
    );
  }
}
