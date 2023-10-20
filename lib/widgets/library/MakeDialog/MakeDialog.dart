part of projectLibrary;

class MakeDialog extends Dialog {
  Widget iconWidget;
  Widget content;
  GlobalKey? stateKey;

  MakeDialog(
      {Key? key,
      required this.iconWidget,
      required this.content,
      this.stateKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MakeDialogContent(
      iconWidget: iconWidget,
      content: content,
      key: stateKey,
    );
  }
}

class MakeDialogContent extends StatefulWidget {
  Widget iconWidget;
  Widget content;

  MakeDialogContent({
    Key? key,
    required this.iconWidget,
    required this.content,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MakeDialogContentState();
  }
}

class MakeDialogContentState extends State<MakeDialogContent> {

  void close() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: 388.w,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(top: 77.w),
                width: 388.w,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: 200.w),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 18.w,horizontal: 32.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40.w),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 77.w,
                        ),
                        widget.content,
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                height: 154.w,
                child: Container(
                  width: 154.w,
                  height: 154.w,
                  child: widget.iconWidget,
                ),
              ),
            ],
          )),
    );
  }
}
