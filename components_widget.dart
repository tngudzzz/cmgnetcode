import 'package:dailytaskapp/controller/task_controller.dart';
import 'package:dailytaskapp/theme_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Inputfield extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  const Inputfield({
    super.key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "  $title",
                style: TextStyle(
                  fontSize: 18,
                  color: Mycolor().textwhite70,
                  fontWeight: FontWeight.w500,
                  fontFamily: Mycolor().font,
                ),
              ),
              title != "날짜"
                  ? Container()
                  : Row(
                      children: [
                        Text(
                          "연속 날짜",
                          style: TextStyle(
                            color: Mycolor().textwhite70,
                            fontFamily: Mycolor().font,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          height: 35,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Obx(
                              () => CupertinoSwitch(
                                  value: Get.find<TaskController>()
                                      .isStraightday
                                      .value,
                                  onChanged: (bool value) {
                                    Get.find<TaskController>()
                                        .updateisStraightday();
                                  }),
                            ),
                          ),
                        ),
                      ],
                    )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.only(left: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Mycolor().backgroundGrey,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    textInputAction: TextInputAction.go,
                    onChanged: (value) {
                      if (title.toString() == "검색") {
                        Get.find<TaskController>().searchTaskList(value);
                      }
                    },
                    readOnly: (widget == null || title.toString() == "검색")
                        ? false
                        : true,
                    autofocus: false,
                    cursorColor: Mycolor().textwhite,
                    controller: controller,
                    style: TextStyle(
                      color: Mycolor().textwhite,
                      fontFamily: Mycolor().font,
                    ),
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: TextStyle(
                        color: Mycolor().textwhite60,
                        fontSize: 16,
                        fontFamily: Mycolor().font,
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 0,
                        ),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 0,
                        ),
                      ),
                    ),
                  ),
                ),
                widget == null
                    ? Container()
                    : Container(
                        child: widget,
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
