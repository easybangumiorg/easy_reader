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
    return SelectedBlock(
      beginIndex: beginIndex,
      endIndex: endIndex,
      innerBeginIndex: innerBeginIndex,
      innerEndIndex: innerEndIndex,
      blocks: _blocks.sublist(beginIndex, endIndex),
    );
  }
}
