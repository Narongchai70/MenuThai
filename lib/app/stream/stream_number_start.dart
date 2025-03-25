import 'dart:async';
import 'package:flutter/material.dart';

class Stream1NumberStart extends StatefulWidget {
  const Stream1NumberStart({super.key});

  @override
  State<Stream1NumberStart> createState() => _StreamNumberStartState();
}

class _StreamNumberStartState extends State<Stream1NumberStart> {
  final StreamController<int> controller = StreamController<int>();
  int count = 1;
  late StreamSubscription<int> subscription;
  bool isCounting = false;

  void startCount() {
    if (!isCounting) {
      isCounting = true;
      subscription = Stream.periodic(
        const Duration(seconds: 1),
        (count) => this.count++,
      ).listen((value) {
        controller.sink.add(value);
      });
    }
  }

  void stopCount() {
    if (isCounting) {
      subscription.cancel();
      isCounting = false;
    }
  }

  void resetCount() {
    stopCount();
    setState(() {
      count = 0;
    });
    controller.sink.add(count);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('นับเลข 1 วิ'), centerTitle: true),
      body: Center(
        child: StreamBuilder<int>(
          stream: controller.stream,
          initialData: 0,
          builder: (context, snapshot) {
            return Text(
              '${snapshot.data}',
              style: const TextStyle(fontSize: 48),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(onPressed: startCount, child: const Text('เริ่ม')),
            ElevatedButton(onPressed: stopCount, child: const Text('หยุด')),
            ElevatedButton(
              onPressed: resetCount,
              child: const Text('รีสตาร์ท'),
            ),
          ],
        ),
      ),
    );
  }
}
