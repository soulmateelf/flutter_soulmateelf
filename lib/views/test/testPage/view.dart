import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/utils/plugin/plugin.dart';

class TestPage extends StatelessWidget {
  TestPage({Key? key}) : super(key: key);

  GlobalKey step1Key = GlobalKey();
  GlobalKey step2Key = GlobalKey();
  GlobalKey step3Key = GlobalKey();
  Widget? overlayChild;

  var step = 0;

  OverlayEntry? overlayEntry;

  Widget getOverlayChild(GlobalKey key) {
    final ctx = key.currentContext!;
    RenderBox renderBox = ctx.findRenderObject() as RenderBox;
    Size size = renderBox.size;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    EdgeInsets margin = getMargin(ctx);
    EdgeInsets padding = getPadding(ctx);
    BorderRadius borderRadius = getBorderRadius(ctx);
    return AnimatedPositioned(
        duration: Duration(milliseconds: 1000),
        top: offset.dy + margin.top,
        left: offset.dx + margin.left,
        child: GestureDetector(
          onTap: () {
            nextStep();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 1000),
            width: size.width - margin.left,
            height: size.height - margin.top,
            decoration:
                BoxDecoration(color: Colors.white, borderRadius: borderRadius),
          ),
        ));
  }

  void createOverlay() {
    overlayEntry = OverlayEntry(builder: (_) {
      return Stack(
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4),
              BlendMode.srcOut,
            ),
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    overlayEntry?.remove();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        backgroundBlendMode: BlendMode.dstOut),
                  ),
                ),
                overlayChild!,
              ],
            ),
          ),
        ],
      );
    });
    Overlay.of(Get.context!).insert(overlayEntry!);
  }

  void nextStep() {
    step++;
    if (step == 1) {
      overlayChild = getOverlayChild(step1Key);
    } else if (step == 2) {
      overlayChild = getOverlayChild(step2Key);
    }
    if (overlayEntry == null) {
      createOverlay();
    } else {
      overlayEntry?.markNeedsBuild();
    }
  }

  EdgeInsets getMargin(BuildContext ctx) {
    Widget? widget = ctx.widget;
    late EdgeInsets margin;
    if (widget != null) {
      if (widget is Container) {
        margin = (widget.margin ?? EdgeInsets.zero) as EdgeInsets;
      }
    }
    return margin;
  }

  EdgeInsets getPadding(BuildContext ctx) {
    Widget? widget = ctx.widget;
    late EdgeInsets padding;
    if (widget != null) {
      if (widget is Container) {
        padding = (widget.padding ?? EdgeInsets.zero) as EdgeInsets;
      } else if (widget is Padding) {
        padding = widget.padding as EdgeInsets;
      }
    }

    return padding;
  }

  BorderRadius getBorderRadius(BuildContext ctx) {
    Widget? widget = ctx.widget;
    BorderRadius borderRadius = BorderRadius.zero;
    if (widget != null) {
      if (widget is Container) {
        var decoration = widget.decoration;
        if (decoration is BoxDecoration) {
          borderRadius =
              (decoration.borderRadius ?? BorderRadius.zero) as BorderRadius;
        }
      }
    }

    return borderRadius;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff9e9e9e),
      child: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          TextButton(
            onPressed: () {
              nextStep();
            },
            child: Text("go"),
          ),
          TextButton(
            onPressed: () {
              step = 0;
              overlayChild = null;
              overlayEntry = null;
            },
            child: Text("reset"),
          ),
          TextButton(
            onPressed: () {
              final parentWidget = step2Key.currentContext!
                      .findAncestorWidgetOfExactType<Padding>() ??
                  step2Key.currentContext!
                      .findAncestorWidgetOfExactType<Container>();
              BuildContext ctx = step2Key.currentContext!;
              Widget widget = ctx.widget;
              if (widget is Container) {}
            },
            child: Text("findWidgetRenderObject"),
          ),
          Container(
            key: step1Key,
            width: 100,
            height: 100,
            color: Colors.red,
            child: Text("Step1"),
          ),
          Container(
            key: step2Key,
            width: 200,
            height: 200,
            margin: EdgeInsets.only(top: 100),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(width: 2)),
            child: Text("Step1"),
          ),
          // Container(
          //   key: step3Key,
          //   width: 200,
          //   height: 100,
          //   margin: EdgeInsets.only(top: 100),
          //   color: Colors.green,
          //   child: Text("Step1"),
          // ),
        ],
      ),
    );
  }
}
