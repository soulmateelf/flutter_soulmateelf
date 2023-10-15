part of projectLibrary;

class MakeInput extends StatefulWidget {
  Widget? suffix;
  Widget? prefix;
  String? hintText;
  double? space;
  EdgeInsetsGeometry? padding;
  Function(String)? onChanged;
  bool error;
  String? errorText;
  Widget? errorWidget;
  bool allowClear;
  Function? onClear;
  bool obscureText;
  TextInputType? keyboardType;
  TextEditingController? controller;

  /// 这些是组件内部自己的状态
  bool focus = false;
  Duration animateDuration = const Duration(milliseconds: 150);

  MakeInput({
    super.key,
    this.prefix,
    this.suffix,
    this.hintText,
    this.space = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 15),
    this.onChanged,
    this.errorText,
    this.errorWidget,
    this.error = false,
    this.allowClear = false,
    this.obscureText = false,
    this.onClear,
    this.keyboardType,
    this.controller,
  }) : assert(((errorText != null && errorWidget == null) ||
                (errorText == null && errorWidget != null) ||
                (errorText == null && errorWidget == null)) &&
            ((allowClear == true && onClear != null) ||
                (allowClear == null && onClear == null)));

  FocusNode focusNode = FocusNode();

  @override
  State<StatefulWidget> createState() {
    return _MakeInput();
  }
}

class _MakeInput extends State<MakeInput> {
  @override
  void initState() {
    // TODO: implement initState
    APPPlugin.logger.d(widget.padding?.horizontal);
    widget.focusNode.addListener(() {
      setState(() {
        var focus = widget.focusNode.hasFocus;
        widget.focus = focus;
      });
    });
    if (widget.controller?.text != null) {
      widget.controller?.selection =
          TextSelection.collapsed(offset: widget.controller!.text.length);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.focusNode.dispose();
  }

  /// 根据传入的状态(error,focus,default)渲染不同的样式
  BoxDecoration getBoxDecoration() {
    if (widget.error == true) {
      return BoxDecoration(
          color: errorBackgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: errorBorderColor,
            width: borderWidth,
          ));
    } else {
      if (widget.focus) {
        return BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: primaryColor,
              width: borderWidth,
            ));
      } else {
        return BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: borderColor,
              width: borderWidth,
            ));
      }
    }
  }

  /// 清除按钮的回调事件
  void clearText() {
    if (widget.allowClear == true && widget.onClear is Function) {
      widget.onClear!();
    }
  }

  /// 渲染suffix 组件
  Widget renderSuffix() {
    if (widget.allowClear == true && widget.focus) {
      return GestureDetector(
        onTap: () {
          clearText();
        },
        child: const Icon(CupertinoIcons.clear_circled_solid),
      );
    } else {
      if (widget.suffix is Widget) {
        return widget.suffix!;
      } else {
        return SizedBox(
          width: 27.w,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        AnimatedContainer(
          padding: widget.padding,
          decoration: getBoxDecoration(),
          height: 64.w,
          duration: widget.animateDuration,
          child: Row(
            children: [
              Container(
                child: widget.prefix,
              ),
              Visibility(
                  visible: widget.prefix != null,
                  child: SizedBox(
                    width: widget.space,
                  )),
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  textAlign: TextAlign.center,
                  obscureText: widget.obscureText,
                  keyboardType: widget.keyboardType,
                  cursorColor: primaryColor,
                  style: TextStyle(fontSize: 18.sp, color: textColor),
                  focusNode: widget.focusNode,
                  onChanged: widget.onChanged,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle:
                        const TextStyle(color: Color.fromRGBO(0, 0, 0, 0.32)),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Visibility(
                  visible: widget.suffix != null && widget.allowClear != true,
                  child: SizedBox(
                    width: widget.space,
                  )),
              Container(
                child: renderSuffix(),
              ),
            ],
          ),
        ),
        AnimatedOpacity(
          opacity:
              (widget.errorWidget != null || widget.errorText != null) ? 1 : 0,
          duration: widget.animateDuration,
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 10.w, 27.w, 0),
            child: Text(
              widget?.errorText ?? "",
              style: const TextStyle(color: errorTextColor),
            ),
          ),
        ),
      ],
    );
  }
}
