import 'dart:async';

import 'package:flutter/material.dart';

class Number extends StatefulWidget {
  Number({super.key});

  @override
  State<Number> createState() => _NumberState();
}

class _NumberState extends State<Number> {
  Stream<DateTime> numberStream() {
    final controller = StreamController<DateTime>();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      controller.add(DateTime.now());
    });

    return controller.stream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TimeStream'), centerTitle: true),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: StreamBuilder(
              stream: numberStream(),
              builder: (context, snapshot) {
                if (snapshot.data == null)
                  return const CircularProgressIndicator();

                return Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: const Color(0xffe0e0e0),
                              border: Border.all(
                                color: const Color(0xFFb4b3b4),
                              ),
                            ),

                            height: 65,
                            width: 65,
                            child: Text(
                              '${snapshot.data!.hour}',
                              style: TextStyle(fontSize: 28),
                            ),
                            alignment: Alignment.center,
                          ),
                          Text('Hour', style: TextStyle(fontSize: 26)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: const Color(0xffe0e0e0),
                              border: Border.all(
                                color: const Color(0xFFb4b3b4),
                              ),
                            ),
                            height: 65,
                            width: 65,
                            child: Text(
                              '${snapshot.data!.minute}',
                              style: TextStyle(fontSize: 28),
                            ),
                            alignment: Alignment.center,
                          ),
                          Text('min', style: TextStyle(fontSize: 26)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: const Color(0xffe0e0e0),
                              border: Border.all(
                                color: const Color(0xFFb4b3b4),
                              ),
                            ),
                            height: 65,
                            width: 65,
                            alignment: Alignment.center,

                            child: Text(
                              '${snapshot.data!.second}',
                              style: TextStyle(fontSize: 28),
                            ),
                          ),
                          Text('second', style: TextStyle(fontSize: 26)),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
