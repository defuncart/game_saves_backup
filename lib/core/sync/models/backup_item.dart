import 'package:clock/clock.dart';

class BackupItem {
  BackupItem({
    required this.id,
    required this.path,
    required this.folderName,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? clock.now();

  final String id;
  final String path;
  final String folderName;
  final DateTime createdAt;

  Map<String, dynamic> toJson() => {
    'id': id,
    'path': path,
    'folderName': folderName,
    'createdAt': createdAt.toIso8601String(),
  };

  factory BackupItem.fromJson(Map<String, dynamic> json) {
    return BackupItem(
      id: json['id'] ?? '',
      path: json['path'] ?? '',
      folderName: json['folderName'] ?? '',
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt'] as String) : null,
    );
  }

  @override
  String toString() => 'BackupItem(id: $id, path: $path, folderName: $folderName, createdAt: $createdAt)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BackupItem &&
        other.id == id &&
        other.path == path &&
        other.folderName == folderName &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode => id.hashCode ^ path.hashCode ^ folderName.hashCode ^ createdAt.hashCode;
}
