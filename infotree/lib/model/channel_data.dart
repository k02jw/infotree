class ChannelData {
  final int id;
  final String name;
  final String description;
  final String logo;
  final int flowers;
  final List<int> notificationIds;
  final List<int> userIds;

  ChannelData({
    required this.id,
    required this.name,
    required this.description,
    required this.logo,
    this.flowers = 0,
    this.notificationIds = const [],
    this.userIds = const [],
  });

  // JSON 데이터를 통해 ChannelData 객체를 생성
  factory ChannelData.fromJson(Map<String, dynamic> json) {
    return ChannelData(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      logo: json['logo'] ?? '',
      flowers: json['flowers'] ?? 0,
      notificationIds: List<int>.from(json['notification_id'] ?? []),
      userIds: List<int>.from(json['users'] ?? []),
    );
  }

  // ChannelData 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'logo': logo,
      'flowers': flowers,
      'notification_id': notificationIds,
      'users': userIds,
    };
  }

  // copyWith 메서드로 객체를 수정할 수 있음
  ChannelData copyWith({
    int? id,
    String? name,
    String? description,
    String? logo,
    int? flowers,
    List<int>? notificationIds,
    List<int>? userIds,
  }) {
    return ChannelData(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      logo: logo ?? this.logo,
      flowers: flowers ?? this.flowers,
      notificationIds: notificationIds ?? this.notificationIds,
      userIds: userIds ?? this.userIds,
    );
  }
}
