import 'package:flutter/material.dart';

class KeepAliveBox extends StatefulWidget {
  final Widget contentWidget;
  const KeepAliveBox({required this.contentWidget, Key? key}) : super(key: key);

  @override
  State<KeepAliveBox> createState() => _KeepAliveBoxState();
}

class _KeepAliveBoxState extends State<KeepAliveBox>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.contentWidget;
  }

  @override
  bool get wantKeepAlive => true;
}
