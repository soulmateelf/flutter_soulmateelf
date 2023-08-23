part of projectLibrary;

/*
 * 时间范围选择器
 * context 上下文
 */
Future<dynamic>? showSingleColumnPicker(
  BuildContext context, {
  String? title = '请选择',
  required list,
  int? activeIndex = 0,
  String? label = 'label',
  String? value = 'value',
}) {
  return showModalBottomSheet<dynamic>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (cxt) {
        if (list.length > 0) {
          return SingleColumnDialog(
              title: title,
              list: list,
              activeIndex: activeIndex,
              label: label,
              value: value);
        }
        return Container();
      });
}

class SingleColumnDialog extends StatefulWidget {
  final String? title;
  final String? label;
  final String? value;
  final List? list;
  final int? activeIndex;
  const SingleColumnDialog(
      {Key? key,
      this.title,
      this.list,
      this.activeIndex,
      this.label,
      this.value})
      : super(key: key);
  @override
  _SingleColumnDialogState createState() => _SingleColumnDialogState();
}

class _SingleColumnDialogState extends State<SingleColumnDialog> {
  List? list = [];
  Map t = {};

  ///picker里滚动控制
  FixedExtentScrollController c1 = FixedExtentScrollController();

  @override
  void initState() {
    super.initState();
    list = widget.list ?? [];
    t = list?[widget.activeIndex ?? 0];

    ///设置延时，为了在picker渲染完之后再进行滚动，否则滚动不生效
    Future.delayed(const Duration(milliseconds: 100), () {
      c1.animateToItem(widget.activeIndex ?? 0,
          duration: const Duration(milliseconds: 100), curve: Curves.linear);
    });
  }

  List<Widget> _pickerList() {
    List<Widget> lists = [];
    lists.add(
      _myTime(c1, list),
    );
    return lists;
  }

  Widget _myTime(controller, lists) {
    return Expanded(
        child: CupertinoPicker(
      scrollController: controller,
      backgroundColor: Colors.white,
      itemExtent: 56.w,
      onSelectedItemChanged: (index) {
        setState(() {
          t = lists[index];
        });
      },
      children: List<Widget>.generate(lists.length, (int index) {
        return Container(
          alignment: Alignment.center,
          height: 56.w,
          child: Text(
            lists[index][widget.label].toString(),
            style: TextStyle(
                color: t[widget.value] == lists[index][widget.value]
                    ? const Color.fromRGBO(43, 80, 230, 1.0)
                    : const Color.fromRGBO(14, 16, 26, 0.45),
                fontSize: ScreenUtil().setSp(16),
                fontWeight: FontWeight.w400),
          ),
        );
      }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(ScreenUtil().setWidth(16)),
          topRight: Radius.circular(ScreenUtil().setWidth(16)),
        ),
      ),
      child: Column(
        children: <Widget>[
          //顶部标题和完成
          Container(
            height: ScreenUtil().setWidth(44),
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(ScreenUtil().setWidth(16)),
                topRight: Radius.circular(ScreenUtil().setWidth(16)),
              ),
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      '取消',
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(17),
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(118, 120, 127, 1)),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    widget.title ?? '',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(17),
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(14, 16, 26, 0.85)),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context, t);
                    },
                    child: Text(
                      '完成',
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(17),
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF007BF5)),
                    ),
                  ),
                )
              ],
            ),
          ),
          const Divider(
            height: 0.5,
            indent: 0.0,
            color: Colors.black12,
          ),
          //底部的picker
          Expanded(
            child: Row(
              children: _pickerList(),
            ),
          )
        ],
      ),
    );
  }
}

Future<dynamic> showSingleColumnPicker2(
  BuildContext context, {
  String title = '请选择',
  @required list,
  String label = 'label',
  String value = 'value',
  String check = 'check',
}) {
  return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        if (list.length > 0) {
          return SingleColumnDialog2(
              title: title,
              list: list,
              label: label,
              value: value,
              check: check);
        }
        return Container();
      });
}

class SingleColumnDialog2 extends StatefulWidget {
  final String? title;
  final String? label;
  final String? value;
  final String? check;
  final List? list;
  const SingleColumnDialog2(
      {Key? key, this.title, this.list, this.label, this.value, this.check})
      : super(key: key);
  @override
  _SingleColumnDialog2State createState() => _SingleColumnDialog2State();
}

class _SingleColumnDialog2State extends State<SingleColumnDialog2> {
  List list = [];

  ///picker里滚动控制
  FixedExtentScrollController c1 = FixedExtentScrollController();

  @override
  void initState() {
    super.initState();
    list = widget.list ?? [];
  }

  Widget _pickerList(context) {
    return Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      onTap: () {
                        setState(() {
                          list[index][widget.check] =
                              !list[index][widget.check];
                        });
                      },
                      title: Text(
                        list[index][widget.label].toString(),
                      ),
                      trailing: RoundCheckBox(
                        value: list[index][widget.check],
                        onChanged: (bool value) {
                          setState(() {
                            list[index][widget.check] = value;
                          });
                        },
                      ),
                    ),
                    const Divider(
                      height: 1.0,
                      indent: 0.0,
                      color: Colors.black12,
                    )
                  ],
                ));
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(ScreenUtil().setWidth(16)),
            topRight: Radius.circular(ScreenUtil().setWidth(16)),
          ),
        ),
        child: Column(
          children: <Widget>[
            //顶部标题和完成
            Container(
              height: ScreenUtil().setWidth(44),
              padding:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(ScreenUtil().setWidth(16)),
                  topRight: Radius.circular(ScreenUtil().setWidth(16)),
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Text(
                      widget.title ?? '',
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(17),
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(14, 16, 26, 0.85)),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context, list);
                      },
                      child: Text(
                        '完成',
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(17),
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF007BF5)),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const Divider(
              height: 0.5,
              indent: 0.0,
              color: Colors.black12,
            ),
            //底部的picker
            Expanded(child: _pickerList(context))
          ],
        ));
  }
}

// ignore: must_be_immutable
class RoundCheckBox extends StatefulWidget {
  bool? value = false;
  Color? color = Colors.white;
  Function(bool)? onChanged;

  RoundCheckBox({Key? key, @required this.value, this.onChanged, this.color})
      : super(key: key);

  @override
  _RoundCheckBoxState createState() => _RoundCheckBoxState();
}

class _RoundCheckBoxState extends State<RoundCheckBox> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          widget.value = !(widget.value ?? false);
          if (widget.onChanged != null) {
            widget.onChanged!(widget.value ?? false);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: widget.value ?? false
              ? Icon(
                  Icons.check_circle,
                  size: 25.0,
                  color: widget.color ?? const Color(0xFF007BF5),
                )
              : Icon(
                  Icons.panorama_fish_eye,
                  size: 25.0,
                  color: widget.color ?? const Color.fromRGBO(211, 211, 213, 1),
                ),
        ));
  }
}
