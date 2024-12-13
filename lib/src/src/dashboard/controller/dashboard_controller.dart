import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:govbot/src/config/api_paths.dart';
import 'package:govbot/src/config/localization/locale_constant.dart';
import 'package:govbot/src/src/dashboard/model/validation_response_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DashboardController extends GetxController {
  RxInt pageValue = 0.obs;
  var activeButtonIndex = 0.obs;
  final localizationController tokenController =
      Get.find<localizationController>();

  void setActiveButton(int index) {
    activeButtonIndex.value = index;
  }

  var messages = <ChatMessage>[].obs;
  var isTyping = false.obs;

  Future<void> sendMessage(String message) async {
    if (message.isEmpty) return;

    // Add the user's message
    messages.add(ChatMessage(text: message, isUserMessage: true));
    isTyping.value = true;

    try {
      final dio = Dio();
      // Replace this URL with your HTTP endpoint
      var token = await tokenController.getToken();
      print('Token: $token');
      final response = await dio.post(
        ApiPaths.validateFact,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token', // Add Bearer token here
          },
        ),
        data: {
          'text': message, // Include the 'text' field
          //'user_id': "1",  // Include the 'user_id' field
        },
      );
      // final response = await http.post(
      //   uri,
      //   headers: {
      //     'Content-Type': 'application/json',
      //     'Authorization': 'Bearer $token',
      //   },
      //   body: jsonEncode({
      //     'text': message, // Include the 'text' field
      //     'user_id': "1" // Include the 'user_id' field
      //   }),
      // );
      if (response.statusCode == 200) {
        final responseData = response.data;
        ValidationResponse validationResponse = ValidationResponse.fromJson(responseData);
        String formattedResponse = validationResponse.getFormattedResponse();
        //print(validationResponse.result);
        print('data: ${validationResponse.result}');
        messages.add(
          ChatMessage(text: formattedResponse, isUserMessage: false),
        );
      } else {
        messages.add(
          ChatMessage(
            text: 'Error: ${response.statusCode} - ${response.data}',
            isUserMessage: false,
          ),
        );
      }
    } catch (e) {
      messages.add(
        ChatMessage(text: 'Failed to connect: $e', isUserMessage: false),
      );
    } finally {
      isTyping.value = false;
    }
  }
}

class ChatMessage {
  final String text;
  final bool isUserMessage;

  ChatMessage({required this.text, required this.isUserMessage});
}

class RequestBody {
  final String text;
  final String user_id;

  RequestBody({required this.text, required this.user_id});
}
