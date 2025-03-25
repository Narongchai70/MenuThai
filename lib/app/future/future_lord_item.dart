import 'package:flutter/material.dart';

class FutureLordItem extends StatefulWidget {
  const FutureLordItem({super.key});

  @override
  State<FutureLordItem> createState() => _FutureLordItemState();
}

class _FutureLordItemState extends State<FutureLordItem> {
  Future<List<String>> fetchItems() async {
    await Future.delayed(Duration(seconds: 3));
    return ["Item 1", "Item 2", "Item 3"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('รายการสินค้า')),
      body: FutureBuilder<List<String>>(
        future: fetchItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            List<String> items = snapshot.data!;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(items[index]));
              },
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'));
          }

          return const Center(child: Text('ไม่มีข้อมูล'));
        },
      ),
    );
  }
}
