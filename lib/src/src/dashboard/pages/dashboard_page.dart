import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:govbot/src/config/theme/theme.dart';
import 'package:govbot/src/src/dashboard/controller/dashboard_controller.dart';
class DashboardPage extends StatelessWidget {
  final DashboardController chatController = Get.put(DashboardController());
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Chat messages list
          Expanded(
            child: Obx(() {
              return ListView.builder(
                reverse: true,
                itemCount: chatController.messages.length,
                itemBuilder: (context, index) {
                  final message = chatController.messages[
                      chatController.messages.length - 1 - index];
                  return ListTile(
                    title: Align(
                      alignment: message.isUserMessage
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: message.isUserMessage
                              ? Colors.blue[100]
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(message.text),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          // Input field and send button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Obx(() {
                    return TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        hintText: chatController.isTyping.value
                            ? 'Checking...'.tr
                            : 'Validate Statement'.tr,
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppTheme.lightAppColors.primary),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppTheme.lightAppColors.primary),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppTheme.lightAppColors.primary),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onSubmitted: (text) {
                        chatController.sendMessage(text);
                        _textEditingController.clear();
                      },
                    );
                  }),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: AppTheme.lightAppColors.primary,
                  ),
                  onPressed: () {
                    chatController.sendMessage(_textEditingController.text);
                    _textEditingController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
