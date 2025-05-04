import 'dart:convert';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatUser _currentUser =
      ChatUser(id: '1', firstName: 'Hussain', lastName: 'Mustafa');

  final ChatUser _gptChatUser =
      ChatUser(id: '2', firstName: 'Chat', lastName: 'GPT');

  List<ChatMessage> _messages = <ChatMessage>[];
  List<ChatUser> _typingUsers = <ChatUser>[];

  var res = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 139, 199, 1),
        title: const Text(
          'My GPT',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: DashChat(
          currentUser: _currentUser,
          typingUsers: _typingUsers,
          messageOptions: const MessageOptions(
            currentUserContainerColor: Colors.black54,
            containerColor: Color.fromRGBO(0, 139, 199, 1),
            textColor: Colors.white,
          ),
          onSend: (ChatMessage m) {
            fetchData(m);
          },
          messages: _messages),
    );
  }

  // Future<void> getChatResponse(ChatMessage m) async {
  //   // setState(() {
  //   //   _messages.insert(0, m);
  //   //   _typingUsers.add(_gptChatUser);
  //   // });
  //   // List<Messages> _messagesHistory = _messages.reversed.map((m) {
  //   //   if (m.user == _currentUser) {
  //   //     return Messages(role: Role.user, content: m.text);
  //   //   } else {
  //   //     return Messages(role: Role.assistant, content: m.text);
  //   //   }
  //   // }).toList();
  //   // final request = ChatCompleteText(
  //   //   model: GptTurbo0301ChatModel(),
  //   //   messages: _messagesHistory,
  //   //   maxToken: 200,
  //   // );
  //   final response = await _openAI.onChatCompletion(request: request);
  //   for (var element in response!.choices) {
  //     if (element.message != null) {
  //       // setState(() {
  //       //   _messages.insert(
  //       //     0,
  //       //     ChatMessage(
  //       //         user: _gptChatUser,
  //       //         createdAt: DateTime.now(),
  //       //         text: element.message!.content),
  //       //   );
  //       // });
  //     }
  //   }
  //   // setState(() {
  //   //   _typingUsers.remove(_gptChatUser);
  //   // });
  // }

  Future<String> fetchData(ChatMessage m) async {
    // Define the URL
    print('mmmmmmmmmm' + m.text);
    setState(() {
      _messages.insert(0, m);
      _typingUsers.add(_gptChatUser);
    });
    List<Messages> _messagesHistory = _messages.reversed.map((m) {
      if (m.user == _currentUser) {
        return Messages(role: Role.user, content: m.text);
      } else {
        return Messages(role: Role.assistant, content: m.text);
      }
    }).toList();
    // Define the request body
    Map<String, String> body = {"query": m.text};

    // Send POST request
    final response = await http.post(
      Uri.parse('http://192.168.43.184:5000/query'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(body),
    );

    // Check if request was successful (status code 200)
    if (response.statusCode == 200) {
      // Decode the response JSON
      Map<String, dynamic> responseData = json.decode(response.body);

      // Extract the owner name from the response
      res = responseData['response'];
      setState(() {
        _messages.insert(
          0,
          ChatMessage(user: _gptChatUser, createdAt: DateTime.now(), text: res),
        );
      });
      // Use the owner name
      print('Owner Name: $res');
      setState(() {
        _typingUsers.remove(_gptChatUser);
      });
      return res;
    } else {
      // If request was not successful, print the status code
      print('Request failed with status: ${response.statusCode}');
    }
    return res;
  }
}
