class UserProfile {
  final int userId;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String api;

  UserProfile({
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.api,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userId: json['userId'] is int
          ? json['userId']
          : int.parse(json['userId'].toString()),
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      api: json['api'] ?? '',
    );
  }
}
