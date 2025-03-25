import 'dart:async';
import 'package:flutter/material.dart';

class StreamCountdown extends StatelessWidget {
  const StreamCountdown({super.key});

  Stream<int> countdownStream(int start) async* {
    for (int i = start; i >= 0; i--) {
      await Future.delayed(const Duration(seconds: 1));
      yield i;
    }
  }

  @override
  Widget build(BuildContext context) {
    const int countdownStart = 10;
    return Scaffold(
      appBar: AppBar(title: const Text('ตัวจับเวลาถอยหลัง'), centerTitle: true),
      body: Center(
        child: StreamBuilder<int>(
          stream: countdownStream(countdownStart),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final value = snapshot.data!;
              return Text(
                value > 0 ? '$value วินาที' : 'หมดเวลา!',
                style: const TextStyle(fontSize: 48),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
