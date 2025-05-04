import 'package:flutter/material.dart';
import 'package:flutter_chatgpt_tutorial_yt/pages/chat_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromRGBO(0, 139, 199, 1)),
        useMaterial3: true,
      ),
      home: ChatPage(),
    );
  }
}
