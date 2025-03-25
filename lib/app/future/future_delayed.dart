import 'package:flutter/material.dart';

class FutureDelayed extends StatelessWidget {
  const FutureDelayed({super.key});

  void showDelayed(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 5));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('การแจ้งเตือน 5 วินาที!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ดีเลย์'), centerTitle: true),
      body: Center(
        child: ElevatedButton(
          onPressed: () => showDelayed(context),
          child: const Text('แสดงแจ้งเตือน'),
        ),
      ),
    );
  }
}
