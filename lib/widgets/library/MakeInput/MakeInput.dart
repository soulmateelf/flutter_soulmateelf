part of projectLibrary;

class MakeInput extends StatefulWidget {
  Widget? suffix;
  bool focusShowSuffix;
  Widget? prefix;
  bool focusShowPrefix;
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
  TextAlign textAlign;
  Alignment errorBoxAligment;
  Function()? onEditingComplete;
  TextInputAction? textInputAction;
  FocusNode? focusNode;
  bool autofocus;

  /// 这些是组件内部自己的状态
  bool focus = false;
  Duration animateDuration = const Duration(milliseconds: 150);

  MakeInput({
    super.key,
    this.prefix,
    this.focusShowPrefix = false,
    this.suffix,
    this.focusShowSuffix = false,
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
    this.textAlign = TextAlign.start,
    this.errorBoxAligment = Alignment.center,
    this.onEditingComplete,
    this.textInputAction,
    this.focusNode,
    this.autofocus = false,
  }) : assert(((errorText != null && errorWidget == null) ||
                (errorText == null && errorWidget != null) ||
                (errorText == null && errorWidget == null)) &&
            ((allowClear && onClear != null) ||
                (!allowClear && onClear == null)));

  @override
  State<StatefulWidget> createState() {
    return _MakeInput();
  }
}

class _MakeInput extends State<MakeInput> {
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    if (widget.focusNode is FocusNode) {
      _focusNode = widget.focusNode!;
    }
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() {
      widget.focus = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _focusNode.dispose();
    super.dispose();
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
    if (_focusNode.hasFocus) {
      widget.focus = _focusNode.hasFocus;
    }
    return Column(
      children: [
        AnimatedContainer(
          padding: widget.padding,
          decoration: getBoxDecoration(),
          height: 64.w,
          duration: widget.animateDuration,
          child: Row(
            children: [
              Visibility(
                visible: ((widget.focusShowPrefix && widget.focus) ||
                    !widget.focusShowPrefix),
                child: Container(
                  child: widget.prefix,
                ),
              ),
              Visibility(
                  visible: widget.prefix != null,
                  child: SizedBox(
                    width: widget.space,
                  )),
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  textAlign: widget.textAlign,
                  obscureText: widget.obscureText,
                  keyboardType: widget.keyboardType,
                  cursorColor: primaryColor,
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: textColor,
                    fontFamily: FontFamily.SFProRoundedMedium,
                  ),
                  textInputAction: widget.textInputAction,
                  onEditingComplete: widget.onEditingComplete,
                  focusNode: _focusNode,
                  onChanged: widget.onChanged,
                  autofocus: widget.autofocus,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: const TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.32),
                      fontFamily: FontFamily.SFProRoundedMedium,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Visibility(
                  visible: widget.suffix != null && widget.allowClear != true,
                  child: SizedBox(
                    width: widget.space,
                  )),
              Visibility(
                visible: ((widget.focusShowSuffix && widget.focus) ||
                    !widget.focusShowPrefix),
                child: Container(
                  child: renderSuffix(),
                ),
              ),
            ],
          ),
        ),
        Visibility(
            maintainSize: true,
            visible: widget.error,
            maintainState: true,
            maintainAnimation: true,
            child: AnimatedOpacity(
              opacity: widget.error ? 1 : 0,
              duration: widget.animateDuration,
              child: Column(
                children: [
                  widget.errorText != null
                      ? Container(
                          margin: EdgeInsets.fromLTRB(0, 10.w, 27.w, 0),
                          alignment: widget.errorBoxAligment,
                          child: Text(
                            widget?.errorText ?? "",
                            style: const TextStyle(
                              color: errorTextColor,
                            ),
                          ),
                        )
                      : (widget?.errorWidget ?? SizedBox()),

                  // Offstage(
                  //   offstage: widget.errorWidget == null,
                  //   child: widget.errorWidget,
                  // ),
                  // Offstage(
                  //   offstage: widget.errorText == null,
                  //   child: AnimatedOpacity(
                  //     opacity: widget.errorText != null ? 1 : 0,
                  //     duration: widget.animateDuration,
                  //     child: Container(
                  //       margin: EdgeInsets.fromLTRB(0, 10.w, 27.w, 0),
                  //       child: Text(
                  //         widget?.errorText ?? "",
                  //         style: const TextStyle(color: errorTextColor),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            )),
      ],
    );
  }
}
