import 'package:easy_reader/easy_reader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// 阅读器视图
class ReaderView extends StatefulWidget {
  final EasyReader reader;

  const ReaderView({
    super.key,
    required this.reader,
  });

  @override
  State<ReaderView> createState() => _ReaderViewState();
}

class _ReaderViewState extends State<ReaderView> {
  @override
  Widget build(BuildContext context) {
    return const ReaderWidget();
  }
}

class ReaderWidget extends MultiChildRenderObjectWidget {
  const ReaderWidget({super.key});

  @override
  RenderReader createRenderObject(BuildContext context) {
    return RenderReader();
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderReader renderObject) {}
}

class ReaderParentData extends ContainerBoxParentData<RenderBox> {}

class RenderReader extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, ReaderParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, ReaderParentData> {
  @override
  bool get sizedByParent => true;

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! ReaderParentData) {
      child.parentData = ReaderParentData();
    }
  }

  @override
  Size computeDryLayout(covariant BoxConstraints constraints) {
    Size size = constraints.biggest;
    return size;
  }

  @override
  void paint(PaintingContext context, Offset offset) {}

  @override
  void handleEvent(PointerEvent event, covariant BoxHitTestEntry entry) {}

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }
}
