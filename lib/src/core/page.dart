import 'core.dart';

/// 分页
class Page {
  /// 上一页
  Page? _previous;

  Page? get previous => _previous;

  /// 下一页
  Page? _next;

  Page? get next => _next;

  /// 页范围
  BlockRange _range;

  BlockRange get range => _range;

  Page({
    Page? previous,
    Page? next,
    required BlockRange range,
  })  : _previous = previous,
        _next = next,
        _range = range!;
}
