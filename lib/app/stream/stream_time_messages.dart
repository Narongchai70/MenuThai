import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: StreamTimeMessages()));
}

class StreamTimeMessages extends StatefulWidget {
  @override
  _StreamTimeMessages createState() => _StreamTimeMessages();
}

class _StreamTimeMessages extends State<StreamTimeMessages> {
  final List<String> oldMessages = [];
  late Stream<String> messageStream;
  late StreamSubscription<String> subscription;

  @override
  void initState() {
    super.initState();
    messageStream = simulateMessageStream();

    subscription = messageStream.listen((message) {
      setState(() {
        oldMessages.insert(0, message);
      });
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  Stream<String> simulateMessageStream() async* {
    for (int i = 1; i <= 10; i++) {
      await Future.delayed(Duration(seconds: 2));
      yield "$i";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('แสดงข้อความเรียลไทม์'), centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              oldMessages.isNotEmpty
                  ? 'ข้อความล่าสุด: ${oldMessages.first}'
                  : 'กำลังรอข้อความ...',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: oldMessages.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(oldMessages[index]));
              },
            ),
          ),
        ],
      ),
    );
  }
}
