import 'package:get/get.dart';

class DashboardController extends GetxController {
  RxInt pageValue = 0.obs;
  var activeButtonIndex = 0.obs;

  void setActiveButton(int index) {
    activeButtonIndex.value = index;
  }
}
