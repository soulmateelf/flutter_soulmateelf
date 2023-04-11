part of projectLibrary;

AppBar backBar() {
  return AppBar(
    elevation: 0,
    leading: Row(children: [
      IconButton(
        icon: Icon(Icons.arrow_back_ios_new),
        onPressed: () {
          Get.back();
        },
        color: Color.fromRGBO(153, 153, 153, 1),
      ),
      Padding(
        padding: EdgeInsets.only(left: 12.w),
        child: const Text(
          "Back",
          style: TextStyle(color: Color.fromRGBO(153, 153, 153, 1)),
        ),
      )
    ]),
    backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
    leadingWidth: 1.sw,
  );
}
