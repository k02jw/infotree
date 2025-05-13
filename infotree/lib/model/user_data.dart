class UserData {
  final int id;
  final String name;
  final String school;
  final String email;
  final String phone;
  final List<String> major;
  final List<int> channel;
  final List<String> categories;
  final List<int> likes;
  final int year;
  final String gender;
  final int grade;

  UserData({
    required this.id,
    required this.name,
    required this.school,
    required this.email,
    required this.phone,
    required this.major,
    required this.channel,
    required this.categories,
    required this.likes,
    required this.year, // New property
    required this.gender, // New property
    required this.grade, // New property
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      school: json['school'],
      email: json['email'],
      phone: json['phone'],
      major: List<String>.from(json['major'] ?? []),
      channel: List<int>.from(json['channel'] ?? []),
      categories: List<String>.from(json['categories'] ?? []),
      likes: List<int>.from(json['likes'] ?? []),
      year: json['year'] ?? 0, // New property
      gender: json['gender'] ?? '', // New property
      grade: json['grade'] ?? 0, // New property
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'school': school,
      'email': email,
      'phone': phone,
      'major': major,
      'channel': channel,
      'categories': categories,
      'likes': likes,
      'year': year, // New property
      'gender': gender, // New property
      'grade': grade, // New property
    };
  }

  UserData copyWith({
    int? id,
    String? name,
    String? school,
    String? email,
    String? phone,
    List<String>? major,
    List<int>? channel,
    List<String>? categories,
    List<int>? likes,
    int? year, // New property
    String? gender, // New property
    int? grade, // New property
  }) {
    return UserData(
      id: id ?? this.id,
      name: name ?? this.name,
      school: school ?? this.school,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      major: major ?? this.major,
      channel: channel ?? this.channel,
      categories: categories ?? this.categories,
      likes: likes ?? this.likes,
      year: year ?? this.year, // New property
      gender: gender ?? this.gender, // New property
      grade: grade ?? this.grade, // New property
    );
  }
}
