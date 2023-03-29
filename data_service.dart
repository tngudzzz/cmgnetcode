import 'package:dailytaskapp/controller/home_controller.dart';
import 'package:dailytaskapp/model/task.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class DataService extends GetxController {
  final String _boxName = "task";

  // HomeController 등록
  final homeController = Get.find<HomeController>();

  RxList taskList = [].obs;
  RxList searchList = [].obs;
  RxList taskUnCompleteList = [].obs;
  RxList taskCompleteList = [].obs;

  // 리스트 초기화
  Future<void> clearList() async {
    taskList.clear();
    taskUnCompleteList.clear();
    taskCompleteList.clear();
    searchList.clear();
  }

  // 날짜 이벤트로 인한 리스트 update
  void updateTaskList(int index) async {
    await clearList();
    var box = await Hive.openBox<TaskModel>(_boxName);
    taskUnCompleteList.value = box.values
        .where((task) =>
            task.date == homeController.hintText.toString() &&
            task.isCompleted == 0)
        .toList();
    taskCompleteList.value = box.values
        .where((task) =>
            task.date == homeController.hintText.toString() &&
            task.isCompleted == 1)
        .toList();
    switch (index) {
      case 0:
        taskList(taskUnCompleteList);
        break;
      case 1:
        taskList(taskCompleteList);
        break;
    }
  }

  // 검색 이벤트로 인한 리스트 update
  void searchTaskList(String data) async {
    await clearList();
    var box = await Hive.openBox<TaskModel>(_boxName);
    searchList.value = box.values
        .where(
            (task) => task.title!.contains(data) || task.note!.contains(data))
        .toList();
  }
}
