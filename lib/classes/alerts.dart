class Alerts {
  String username;
  String body_image;
  String user_image;

  String details;
  String short_description;

  Alerts({
    required this.username,
    required this.short_description,
    required this.user_image, // Added comma here
    required this.details,
    required this.body_image,
  });

  factory Alerts.fromJson(Map<String, dynamic> json) {
    return Alerts(
      username: json['username'] ?? '',
      user_image: json['user_image'] ?? '',
      body_image: json['body_image'] ?? '',
      details: json['details'] ?? '',
      short_description: json['short_description'] ?? '',
    );
  }
}
