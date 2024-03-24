import 'dart:ui';

import 'core.dart';

/// 块范围
class BlockRange {
  /// 开始索引
  final int begin;

  /// 结束索引
  final int end;

  /// 开始块内部索引
  final int innerBegin;

  /// 结束块内部索引
  /// -1表示整块
  final int innerEnd;

  const BlockRange({
    required this.begin,
    required this.end,
    required this.innerBegin,
    required this.innerEnd,
  });

  BlockRange copyWith({
    int? begin,
    int? end,
    int? innerBegin,
    int? innerEnd,
  }) {
    return BlockRange(
      begin: begin ?? this.begin,
      end: end ?? this.end,
      innerBegin: innerBegin ?? this.innerBegin,
      innerEnd: innerEnd ?? this.innerEnd,
    );
  }

  @override
  int get hashCode => Object.hash(begin, end, innerBegin, innerEnd);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BlockRange &&
        begin == other.begin &&
        end == other.end &&
        innerBegin == other.innerBegin &&
        innerEnd == other.innerEnd;
  }
}

///选择块
class SelectedBlock {
  /// 选择范围
  final BlockRange range;

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
        if (range.innerBegin >= block.length || range.innerBegin < 0) {
          throw EasyArgumentError('innerBegin out of range');
        }
        data = block.data.substring(range.innerBegin);
      } else if (i == _blocks.length - 1) {
        if (range.innerEnd > block.length || range.innerEnd < -1) {
          throw EasyArgumentError('innerEnd out of range');
        }
        data = block.data
            .substring(0, range.innerEnd == -1 ? null : range.innerEnd);
      }
      str.write(data);
    }
    return str.toString();
  }

  SelectedBlock({
    required this.range,
    required List<ElementBlock> blocks,
  }) : _blocks = blocks;

  SelectedBlock copyWith({
    BlockRange? range,
    List<ElementBlock>? blocks,
  }) {
    return SelectedBlock(
      range: range ?? this.range,
      blocks: blocks ?? _blocks,
    );
  }

  @override
  int get hashCode => Object.hash(range, _blocks);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SelectedBlock && range == other.range;
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
