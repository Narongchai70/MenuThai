import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: FutureLordData()));
}

class FutureLordData extends StatelessWidget {
  Future<String> loadData() {
    return Future.delayed(Duration(seconds: 3), () => "โหลดข้อมูลเสร็จแล้ว!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('โหลดข้อมูล')),
      body: Center(
        child: FutureBuilder<String>(
          future: loadData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasData) {
              return Text(
                snapshot.data!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              );
            } else {
              return Text('เกิดข้อผิดพลาด');
            }
          },
        ),
      ),
    );
  }
}
