import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:govbot/src/config/theme/theme.dart';
import 'package:govbot/src/src/reports/controller/report_controller.dart';
import 'package:intl/intl.dart';  // For formatting DateTime

class ReportPage extends StatelessWidget {
  final ReportController reportController = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Reports'.tr, style: const TextStyle(color: Colors.white),),
        backgroundColor: AppTheme.lightAppColors.primary,
      ),
      body: Obx(() {
        if (reportController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: reportController.reports.length,
          itemBuilder: (context, index) {
            final report = reportController.reports[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              elevation: 4,
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: Text(
                  report.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppTheme.lightAppColors.primary,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(report.description),
                    const SizedBox(height: 8),
                    Text(
                      'Created at: ${DateFormat('yyyy-MM-dd HH:mm').format(report.createdAt)}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddReportDialog(context);
        },
        backgroundColor: AppTheme.lightAppColors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }

  // Show the modal to add a new report
  void _showAddReportDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:  Text('Add New Report'.tr),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'.tr),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'.tr),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel'.tr),
            ),
            TextButton(
              onPressed: () {
                final title = titleController.text;
                final description = descriptionController.text;
                if (title.isNotEmpty && description.isNotEmpty) {
                  reportController.addReport(title, description);
                  Get.back();
                } else {
                  Get.snackbar('Error', 'Please fill in both fields');
                }
              },
              child: Text('Submit'.tr),
            ),
          ],
        );
      },
    );
  }
}
