import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:govbot/src/config/theme/theme.dart';
import 'package:govbot/src/src/history/controller/history_controller.dart';

class HistoryPage extends StatelessWidget {
  final HistoryController historyController = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('History'.tr, style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xffF7941F),
        elevation: 0,
      ),
      body: Obx(() {
        if (historyController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
            ),
          );
        }

        if (historyController.historyList.isEmpty) {
          return const Center(
            child: Text(
              'No history available.',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: historyController.historyList.length,
          itemBuilder: (context, index) {
            final item = historyController.historyList[index];

            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.text,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Result: ${item.result}',
                      style: const TextStyle(fontSize: 14, color: Colors.blueGrey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Confidence: ${item.confidence.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 14, color: Colors.blueGrey),
                    ),
                    if (item.citations.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      const Text(
                        'Citations:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      for (var citation in item.citations)
                        Text(
                          citation,
                          style: const TextStyle(fontSize: 12, color: Colors.blue),
                        ),
                    ],
                    if (item.inconsistencies.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      const Text(
                        'Inconsistencies:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      for (var inconsistency in item.inconsistencies)
                        Text(
                          inconsistency,
                          style: const TextStyle(fontSize: 12, color: Colors.red),
                        ),
                    ],
                    if (item.origin.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      const Text(
                        'Origin:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      for (var origin in item.origin)
                        Text(
                          origin,
                          style: const TextStyle(fontSize: 12, color: Colors.green),
                        ),
                    ],
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
