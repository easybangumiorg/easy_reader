import 'dart:ui';

import 'core.dart';

///选择块
class SelectedBlock {
  /// 开始索引
  final int beginIndex;

  /// 结束索引
  final int endIndex;

  /// 开始块内部索引
  final int innerBeginIndex;

  /// 结束块内部索引
  /// -1表示整块
  final int innerEndIndex;

  /// 选择的块
  final List<ElementBlock> _blocks;

  /// 获取选择文本
  String get text {
    if (_blocks.isEmpty) {
      return '';
    }
    if (_blocks.length == 1) {
      if (_blocks.first is TextBlock) {
        return (_blocks.first as TextBlock).data;
      }
      return '';
    }
    final str = StringBuffer();
    for (int i = 0; i < _blocks.length; i++) {
      final block = _blocks[i];
      if (block is! TextBlock) {
        continue;
      }
      String data = block.data;
      if (i == 0) {
        if (innerBeginIndex >= block.length || innerBeginIndex < 0) {
          throw EasyArgumentError('innerBeginIndex out of range');
        }
        data = block.data.substring(innerBeginIndex);
      } else if (i == _blocks.length - 1) {
        if (innerEndIndex > block.length || innerEndIndex < -1) {
          throw EasyArgumentError('innerEndIndex out of range');
        }
        data =
            block.data.substring(0, innerEndIndex == -1 ? null : innerEndIndex);
      }
      str.write(data);
    }
    return str.toString();
  }

  SelectedBlock({
    required this.beginIndex,
    required this.innerBeginIndex,
    required this.endIndex,
    required this.innerEndIndex,
    required List<ElementBlock> blocks,
  }) : _blocks = blocks;

  SelectedBlock copyWith({
    int? beginIndex,
    int? innerBeginIndex,
    int? endIndex,
    int? innerEndIndex,
    List<ElementBlock>? blocks,
  }) {
    return SelectedBlock(
      beginIndex: beginIndex ?? this.beginIndex,
      innerBeginIndex: innerBeginIndex ?? this.innerBeginIndex,
      endIndex: endIndex ?? this.endIndex,
      innerEndIndex: innerEndIndex ?? this.innerEndIndex,
      blocks: blocks ?? _blocks,
    );
  }

  @override
  int get hashCode =>
      Object.hash(beginIndex, innerBeginIndex, endIndex, innerEndIndex);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SelectedBlock &&
        beginIndex == other.beginIndex &&
        innerBeginIndex == other.innerBeginIndex &&
        endIndex == other.endIndex &&
        innerEndIndex == other.innerEndIndex;
  }
}

/// 混合长度
mixin ElementLengthMixin<BlockDataType> on ElementBlock<BlockDataType> {
  late final int length;
}

/// 混合大小
mixin ElementSizeMixin<BlockDataType> on ElementBlock<BlockDataType> {
  late final Size size;
}

/// 混合位置
mixin ElementOffsetMixin<BlockDataType> on ElementBlock<BlockDataType> {
  late final Offset offset;
}

/// 混合区域
mixin ElementRectMixin<BlockDataType>
    on ElementSizeMixin<BlockDataType>, ElementOffsetMixin<BlockDataType> {
  Rect get rect => Rect.fromLTWH(offset.dx, offset.dy, size.width, size.height);
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
    if (identical(this, other)) return true;
    return other is ElementBlock && other.index == index && other.data == data;
  }
}

/// 文本块
class TextBlock extends ElementBlock<String> with ElementLengthMixin {
  TextBlock({required super.index, required super.data}) {
    length = data.length;
  }

  TextBlock copyWith({int? index, String? data}) {
    return TextBlock(
      index: index ?? this.index,
      data: data ?? this.data,
    );
  }

  @override
  int get hashCode => Object.hash(super.hashCode, length);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TextBlock && super == other && other.length == length;
  }
}

/// 图片块
class ImageBlock extends ElementBlock<Uri> with ElementSizeMixin {
  ImageBlock({required super.index, required super.data, required Size size}) {
    this.size = size;
  }

  ImageBlock copyWith({int? index, Uri? data, Size? size}) {
    return ImageBlock(
      index: index ?? this.index,
      data: data ?? this.data,
      size: size ?? this.size,
    );
  }

  @override
  int get hashCode => Object.hash(super.hashCode, size);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ImageBlock && super == other && other.size == size;
  }
}
