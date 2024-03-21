import 'dart:ui';

/// 混合长度
mixin ElementLengthMixin<BlockDataType> on ElementBlock<BlockDataType> {
  late final int length;
}

/// 混合大小
mixin ElementSizeMixin<BlockDataType> on ElementBlock<BlockDataType> {
  late final Size size;
}

/// 块
abstract class ElementBlock<BlockDataType> {
  /// 块在文档中的全局索引
  final int index;

  /// 块数据
  final BlockDataType data;

  const ElementBlock({required this.index, required this.data});

  @override
  int get hashCode => Object.hash(index, data);

  @override
  bool operator ==(Object other) {
    return other is ElementBlock && other.index == index && other.data == data;
  }
}

/// 文本块
class TextBlock extends ElementBlock<String> with ElementLengthMixin {
  TextBlock({required super.index, required super.data}) {
    length = data.length;
  }

  @override
  int get hashCode => Object.hash(super.hashCode, length);

  @override
  bool operator ==(Object other) {
    return other is TextBlock && super == other && other.length == length;
  }
}

/// 图片块
class ImageBlock extends ElementBlock<Uri> with ElementSizeMixin {
  ImageBlock({required super.index, required super.data, required Size size}) {
    this.size = size;
  }

  @override
  int get hashCode => Object.hash(super.hashCode, size);

  @override
  bool operator ==(Object other) {
    return other is ImageBlock && super == other && other.size == size;
  }
}
