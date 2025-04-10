class UserData {
  int id;
  String name;
  String school;
  String email;
  String phone;
  List<String> major;
  List<int> channel;
  List<String> keywords;
  List<int> likes;

  UserData({
    required this.id,
    required this.name,
    required this.school,
    required this.email,
    required this.phone,
    required this.major,
    required this.channel,
    required this.keywords,
    required this.likes,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      school: json['school'],
      email: json['email'],
      phone: json['phone'],
      major: List<String>.from(json['major']),
      channel: List<int>.from(json['channel']),
      keywords: List<String>.from(json['keywords']),
      likes: List<int>.from(json['likes']),
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
      'keywords': keywords,
      'likes': likes,
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
    List<String>? keywords,
    List<int>? likes,
  }) {
    return UserData(
      id: id ?? this.id,
      name: name ?? this.name,
      school: school ?? this.school,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      major: major ?? this.major,
      channel: channel ?? this.channel,
      keywords: keywords ?? this.keywords,
      likes: likes ?? this.likes,
    );
  }
}
