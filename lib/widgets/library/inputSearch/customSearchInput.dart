part of projectLibrary;

/// Author trevor
/// Date 2/10/22 2:29 PM
/// Description 自定义搜索框组件
class CustomSearchInput extends StatefulWidget {
  final String searchVal;
  final String? hintString;
  final bool showCancel;
  final Function? changeCallBack;
  final Function? submitCallBack;
  final Function? clearCallBack;
  final Function? cancelCallBack;
  final Function? focusCallBack;

  const CustomSearchInput(
      {Key? key,
      required this.searchVal,
      this.hintString,
      this.showCancel = true,
      this.changeCallBack,
      this.submitCallBack,
      this.cancelCallBack,
      this.focusCallBack,
      this.clearCallBack})
      : super(key: key);

  @override
  _CustomSearchInputState createState() => _CustomSearchInputState();
}

class _CustomSearchInputState extends State<CustomSearchInput> {
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool hasFocus = false;

  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.searchVal;
    _focusNode.addListener(() {
      if (widget.focusCallBack != null) {
        widget.focusCallBack!(_focusNode.hasFocus);
      }
      setState(() {
        hasFocus = _focusNode.hasFocus;
      });
    });
  }

  Widget inputDom() {
    return Container(
      height: 36.w,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(219, 219, 219, 1),
          borderRadius: BorderRadius.circular(8.w)),
      child: TextField(
        focusNode: _focusNode,
        controller: _textEditingController,
        style:
            const TextStyle(fontSize: 14, color: Color.fromRGBO(0, 0, 0, 0.85)),
        textInputAction: TextInputAction.search,
        onChanged: (String str) {
          if (widget.changeCallBack != null) {
            widget.changeCallBack!(str);
          }
        },
        onSubmitted: (String str) {
          if (widget.submitCallBack != null) {
            widget.submitCallBack!(str);
          }
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          hintText: widget.hintString,
          hintStyle: TextStyle(
            fontSize: 14.sp,
            color: const Color.fromRGBO(0, 0, 0, 0.48),
          ),
          prefixIconConstraints: BoxConstraints(maxWidth: 25.w),
          prefixIcon: SizedBox(
            height: 17.w,
            width: 25.w,
            child: Icon(
              Icons.search,
              size: 17.w,
              color: const Color.fromRGBO(0, 0, 0, 0.48),
            ),
          ),
          suffixIconConstraints: BoxConstraints(maxWidth: 25.w),
          suffixIcon: Offstage(
            offstage: widget.searchVal == '',
            child: GestureDetector(
                onTap: () {
                  // 保证在组件build的第一帧时才去触发取消清空内容
                  WidgetsBinding.instance.addPostFrameCallback(
                      (_) => _textEditingController.clear());
                  if (widget.clearCallBack != null) {
                    widget.clearCallBack!();
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/icons/clear_icon.png',
                        width: 20, height: 20),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: inputDom(),
        ),
        Visibility(
            visible: hasFocus && widget.showCancel,
            child: GestureDetector(
              child: Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Text(
                  '取消',
                  style: TextStyle(
                      color: const Color.fromRGBO(0, 123, 245, 1),
                      fontSize: 14.sp),
                ),
              ),
              onTap: () {
                _focusNode.unfocus();
                _textEditingController.clear();
                if (widget.cancelCallBack != null) {
                  widget.cancelCallBack!();
                }
              },
            ))
      ],
    );
  }
}
