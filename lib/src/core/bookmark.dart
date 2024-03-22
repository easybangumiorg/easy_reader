/// 书签
class Bookmark {
  /// 书签名
  final String name;

  /// 描述
  final String description;

  /// 开始索引
  final int beginIndex;

  /// 结束索引
  final int endIndex;

  /// 开始块内部索引
  final int beginBlockIndex;

  /// 结束块内部索引
  final int endBlockIndex;

  const Bookmark({
    required this.name,
    required this.description,
    required this.beginIndex,
    required this.endIndex,
    required this.beginBlockIndex,
    required this.endBlockIndex,
  });

  Bookmark copyWith({
    String? name,
    String? description,
    int? beginIndex,
    int? endIndex,
    int? beginBlockIndex,
    int? endBlockIndex,
  }) {
    return Bookmark(
      name: name ?? this.name,
      description: description ?? this.description,
      beginIndex: beginIndex ?? this.beginIndex,
      endIndex: endIndex ?? this.endIndex,
      beginBlockIndex: beginBlockIndex ?? this.beginBlockIndex,
      endBlockIndex: endBlockIndex ?? this.endBlockIndex,
    );
  }

  @override
  int get hashCode => Object.hash(
      name, description, beginIndex, beginBlockIndex, endIndex, endBlockIndex);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Bookmark &&
        name == other.name &&
        description == other.description &&
        beginIndex == other.beginIndex &&
        beginBlockIndex == other.beginBlockIndex &&
        endIndex == other.endIndex &&
        endBlockIndex == other.endBlockIndex;
  }
}
