// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Wallpaper {
  final String wallpaperName;
  final String wallpaperCategory;
  final String wallpaperUrl;
  final String name;
  Wallpaper({
    required this.wallpaperName,
    required this.wallpaperCategory,
    required this.wallpaperUrl,
    required this.name,
  });

  Wallpaper copyWith({
    String? wallpaperName,
    String? wallpaperCategory,
    String? wallpaperUrl,
    String? name,
  }) {
    return Wallpaper(
      wallpaperName: wallpaperName ?? this.wallpaperName,
      wallpaperCategory: wallpaperCategory ?? this.wallpaperCategory,
      wallpaperUrl: wallpaperUrl ?? this.wallpaperUrl,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'wallpaperName': wallpaperName,
      'wallpaperCategory': wallpaperCategory,
      'wallpaperUrl': wallpaperUrl,
      'name': name,
    };
  }

  factory Wallpaper.fromMap(Map<String, dynamic> map) {
    return Wallpaper(
      wallpaperName: map['wallpaperName'] as String,
      wallpaperCategory: map['wallpaperCategory'] as String,
      wallpaperUrl: map['wallpaperUrl'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Wallpaper.fromJson(String source) =>
      Wallpaper.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Wallpaper(wallpaperName: $wallpaperName, wallpaperCategory: $wallpaperCategory, wallpaperUrl: $wallpaperUrl, name: $name)';
  }

  @override
  bool operator ==(covariant Wallpaper other) {
    if (identical(this, other)) return true;

    return other.wallpaperName == wallpaperName &&
        other.wallpaperCategory == wallpaperCategory &&
        other.wallpaperUrl == wallpaperUrl &&
        other.name == name;
  }

  @override
  int get hashCode {
    return wallpaperName.hashCode ^
        wallpaperCategory.hashCode ^
        wallpaperUrl.hashCode ^
        name.hashCode;
  }
}
