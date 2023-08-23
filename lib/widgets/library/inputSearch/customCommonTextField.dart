part of projectLibrary;

/// Author trevor
/// Date 2/23/22 11:22 AM
/// Description 自定义普通文本框
class CustomCommonTextField extends StatefulWidget {
  final String? inputStr;

  ///默认值
  final String? placeHolder;

  ///提示语
  final int? maxLength;

  ///最长字数
  final int? minLines;

  ///最小行数
  final int? maxLines;

  ///最大行数
  final Function? confirmCallBack;

  ///失去焦点或者完成编辑
  final Function? changeCallBack;

  ///值改变回调

  final bool readOnly;

  ///是否只读

  final String readOnlyHintText;

  ///只读提示

  const CustomCommonTextField({
    Key? key,
    this.inputStr,
    this.placeHolder,
    this.maxLength,
    this.minLines,
    this.maxLines,
    this.confirmCallBack,
    this.changeCallBack,
    this.readOnly = false,
    this.readOnlyHintText = "",
  }) : super(key: key);

  @override
  _CustomCommonTextFieldState createState() => _CustomCommonTextFieldState();
}

class _CustomCommonTextFieldState extends State<CustomCommonTextField> {
  late TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  String _inputStr = '';
  String _placeHolder = '';

  @override
  void initState() {
    super.initState();
    _inputStr = widget.inputStr ?? '';
    _placeHolder = widget.placeHolder ?? '请输入';
    _textEditingController.text = _inputStr;
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        ///失去焦点
        if (widget.confirmCallBack != null) {
          widget.confirmCallBack!(_inputStr);
        }
      }
    });
  }

  @override
  void didUpdateWidget(CustomCommonTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    _inputStr = widget.inputStr ?? '';
    _textEditingController.value = TextEditingValue(
        text: _inputStr,
        selection: TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream, offset: _inputStr.length)));
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      minLines: widget.minLines,
      maxLines: widget.maxLines ?? 1,
      maxLength: widget.maxLength,
      focusNode: _focusNode,
      readOnly: widget.readOnly,
      style: TextStyle(fontSize: 14.sp, color: const Color(0xCC000000)),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: widget.readOnly ? widget.readOnlyHintText : _placeHolder,
        hintStyle: TextStyle(fontSize: 14.sp, color: const Color(0x3D000000)),
      ),
      onChanged: (str) {
        _inputStr = str;
        if (widget.changeCallBack != null) {
          widget.changeCallBack!(str);
        }
      },
      onSubmitted: (str) {
        _inputStr = str;
        if (widget.confirmCallBack != null) {
          widget.confirmCallBack!(str);
        }
      },
    );
  }
}
