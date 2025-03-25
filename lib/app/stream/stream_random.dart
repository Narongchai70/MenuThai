import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: StreamRandom()));
}

class StreamRandom extends StatefulWidget {
  @override
  _StreamRandom createState() => _StreamRandom();
}

class _StreamRandom extends State<StreamRandom> {
  final List<String> notifications = [
    "อากาศร้อน",
    "ฝนตก",
    "มีโปรโมชั่นใหม่!",
    "ลดราคาสินค้า!",
    "โปรดระวังพายุ",
  ];

  late StreamController<String> _controller;
  Timer? _timer;
  String latestNotification = "";

  @override
  void initState() {
    super.initState();
    _controller = StreamController<String>();
    startNotificationStream();
  }

  void startNotificationStream() {
    _timer = Timer.periodic(Duration(seconds: 5), (_) {
      final randomIndex = Random().nextInt(notifications.length);
      final randomMessage = notifications[randomIndex];
      _controller.add(randomMessage);
    });
  }

  void stopNotificationStream() {
    _timer?.cancel();
    _controller.close();
  }

  @override
  void dispose() {
    stopNotificationStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('สุ่ม'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            StreamBuilder<String>(
              stream: _controller.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  latestNotification = snapshot.data!;
                  return Text(
                    'แจ้งเตือนล่าสุด: $latestNotification',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  );
                } else {
                  return Text('กำลังรอการแจ้งเตือน...');
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                stopNotificationStream();
                setState(() {
                  latestNotification = "แจ้งเตือนถูกหยุดแล้ว";
                });
              },
              child: Text('หยุดแจ้งเตือน'),
            ),
          ],
        ),
      ),
    );
  }
}
