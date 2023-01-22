import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class WidgetSizeOffset extends StatefulWidget {
  final Widget child;
  final Function(Size size, Offset offset) onChange;
  final GlobalKey globalKey;

  const WidgetSizeOffset({
    required this.onChange,
    required this.child,
    required this.globalKey,
  });

  @override
  _WidgetSizeOffsetState createState() => _WidgetSizeOffsetState();
}

class _WidgetSizeOffsetState extends State<WidgetSizeOffset> {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    return Container(
      key: widget.globalKey,
      child: widget.child,
    );
  }

  var oldSize;

  void postFrameCallback(_) {
    var context = widget.globalKey.currentContext;
    if (context == null) return;

    var newSize = context.size;
    // if (oldSize == newSize) return;

    oldSize = newSize;
    RenderBox box = widget.globalKey.currentContext?.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero);
    widget.onChange(newSize ?? Size(0, 0), position);
  }
}
