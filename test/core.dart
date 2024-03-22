import 'dart:ui';

import 'package:easy_reader/easy_reader.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('block', () {
    int i = 0;
    final blocks = <ElementBlock>[
      TextBlock(index: i++, data: 'ABCDEFG'),
      TextBlock(index: i++, data: 'HIJKLMN'),
      ImageBlock(index: i++, data: Uri.parse('test://test'), size: Size.zero),
      TextBlock(index: i++, data: 'OPQRSTUVWXYZ'),
    ];
    final reader = EasyReader(blocks: blocks);
    test('SelectedBlock', () {
      SelectedBlock selectedBlock = reader.getSelectedBlock(
        beginIndex: 0,
        endIndex: 4,
        innerBeginIndex: 0,
        innerEndIndex: -1,
      );
      expect(selectedBlock.text, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
      selectedBlock = reader.getSelectedBlock(
        beginIndex: 1,
        endIndex: 4,
        innerBeginIndex: 4,
        innerEndIndex: 3,
      );
      expect(selectedBlock.text, 'LMNOPQ');
    });
  });
}
