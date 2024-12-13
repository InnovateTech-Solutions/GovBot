import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:govbot/src/config/api_paths.dart';
import 'package:govbot/src/config/localization/locale_constant.dart';
import 'package:govbot/src/src/history/model/history_model.dart';

class HistoryController extends GetxController {
  RxList<HistoryItem> historyList = <HistoryItem>[].obs;
  RxBool isLoading = false.obs;
  final localizationController tokenController =
      Get.find<localizationController>();

  @override
  void onInit() {
    super.onInit();
    fetchHistory(); // Fetch the history data as soon as the controller is initialized
  }

  Future<void> fetchHistory() async {
    isLoading.value = true;
    try {
      var token = await tokenController
          .getToken(); // Replace with your method to fetch the token
      var dio = Dio();
      final response = await dio.get(
        ApiPaths.getAllHistory,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Include the token in the header
          },
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        historyList.value = data.map((e) => HistoryItem.fromJson(e)).toList();
      } else {
        print("Error fetching data: ${response.statusCode}");
      }
    } catch (e) {
      print("Failed to fetch history: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
