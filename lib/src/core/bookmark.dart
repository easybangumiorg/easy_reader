import 'core.dart';

/// 书签
class Bookmark {
  /// 书签名
  final String name;

  /// 描述
  final String description;

  /// 范围,通常只有一个块
  final BlockRange range;

  const Bookmark({
    required this.name,
    required this.description,
    required this.range,
  });

  Bookmark copyWith({
    String? name,
    String? description,
    BlockRange? range,
  }) {
    return Bookmark(
      name: name ?? this.name,
      description: description ?? this.description,
      range: range ?? this.range,
    );
  }

  @override
  int get hashCode => Object.hash(name, description, range);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Bookmark &&
        name == other.name &&
        description == other.description &&
        range == other.range;
  }
}
