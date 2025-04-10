class NotificationData {
  final int id;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final String description;
  final int ownerId;
  final int channelId;
  final String? image;
  final String? link;
  final double? latitude;
  final double? longitude;
  final int likes;

  NotificationData({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.ownerId,
    required this.channelId,
    required this.likes,
    this.image,
    this.link,
    this.latitude,
    this.longitude,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      description: json['description'] ?? '',
      ownerId: json['owner_id'] ?? 0,
      channelId: json['channel_id'] ?? 0,
      image: json['image'], // nullable 가능
      link: json['link'],
      likes: json['likes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'description': description,
      'owner_id': ownerId,
      'channel_id': channelId,
      'image': image,
      'link': link,
      'latitude': latitude,
      'longitude': longitude,
      'likes': likes,
    };
  }
}
