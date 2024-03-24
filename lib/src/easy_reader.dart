import 'core/core.dart';

class EasyReader {
  /// 块列表
  final List<ElementBlock> _blocks;

  /// 首页
  Page? _firstPage;

  EasyReader({required List<ElementBlock> blocks}) : _blocks = blocks;

  /// 选择块
  SelectedBlock getSelectedBlock({
    required int begin,
    required int end,
    required int innerBegin,
    required int innerEnd,
  }) {
    if (begin < 0 || begin >= _blocks.length) {
      throw EasyArgumentError('begin out of range');
    }
    if (end < -1 || end > _blocks.length) {
      throw EasyArgumentError('end out of range');
    }
    return SelectedBlock(
      range: BlockRange(
        begin: begin,
        end: end,
        innerBegin: innerBegin,
        innerEnd: innerEnd,
      ),
      blocks: _blocks.sublist(begin, end == -1 ? null : end),
    );
  }
}
