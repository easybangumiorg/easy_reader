import 'core/core.dart';

class EasyReader {
  /// 块列表
  final List<ElementBlock> _blocks;

  EasyReader({required List<ElementBlock> blocks}) : _blocks = blocks;

  /// 选择块
  SelectedBlock getSelectedBlock({
    required int beginIndex,
    required int endIndex,
    required int innerBeginIndex,
    required int innerEndIndex,
  }) {
    if (beginIndex < 0 || beginIndex >= _blocks.length) {
      throw EasyArgumentError('beginIndex out of range');
    }
    if (endIndex < -1 || endIndex > _blocks.length) {
      throw EasyArgumentError('endIndex out of range');
    }
    return SelectedBlock(
      beginIndex: beginIndex,
      endIndex: endIndex,
      innerBeginIndex: innerBeginIndex,
      innerEndIndex: innerEndIndex,
      blocks: _blocks.sublist(beginIndex, endIndex == -1 ? null : endIndex),
    );
  }
}
