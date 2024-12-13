import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:govbot/src/config/api_paths.dart';
import 'package:govbot/src/config/localization/locale_constant.dart';
import 'package:govbot/src/src/reports/model/report_model.dart';

class ReportController extends GetxController {
  final localizationController tokenController =
      Get.find<localizationController>();

  var isLoading = false.obs;
  var reports = <Report>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchReports(); // Fetch the history data as soon as the controller is initialized
  }
  Dio dio = Dio(); // Create Dio instance

  // Fetch reports for the current user
  Future<void> fetchReports() async {
    isLoading(true);
    try {
      var token = await tokenController
          .getToken(); // Replace with your method to fetch the token
      var response = await dio.get(ApiPaths.userReports,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));

      List<dynamic> data = response.data['reports'];
      reports.clear();
      reports.addAll(data.map((json) => Report.fromJson(json)).toList());
    } catch (e) {
      Get.snackbar('Error', 'Failed to load reports');
    } finally {
      isLoading(false);
    }
  }

  // Add a new report
  Future<void> addReport(String title, String description) async {
    isLoading(true);
    try {
      var token = await tokenController
          .getToken(); // Replace with your method to fetch the token
      var response = await dio.post(
        ApiPaths.addReport,
        data: {
          'title': title,
          'description': description,
        },
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Report added successfully!');
        fetchReports(); // Refresh the list after adding a report
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to add report');
    } finally {
      isLoading(false);
    }
  }
}
