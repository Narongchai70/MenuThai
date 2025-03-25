import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  final Map data;
  const Menu({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text('รายละเอียด'),
        centerTitle: true,
        backgroundColor: Colors.grey.shade50,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Hero(
              tag: data['image_url'],
              child: Image.network(
                '${data['image_url']}',
                height: MediaQuery.sizeOf(context).height * .4,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 220,
                    color: Colors.grey.shade500,
                    child: const Icon(
                      Icons.photo_outlined,
                      color: Colors.white,
                      size: 50,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 220,
                    color: Colors.grey.shade500,
                    child: const Icon(
                      Icons.error_outline,
                      color: Colors.white,
                      size: 50,
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: double.infinity),
                    SizedBox(height: 16),
                    Text(
                      '${data['menu_name']}',
                      maxLines: 2,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(height: 4),
                    Text(
                      'โดย: ${data['chef']['name']}',
                      maxLines: 1,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.copyWith(color: Colors.grey),
                    ),
                    SizedBox(height: 24),
                    Text(
                      '${data['ingredients']}',
                      maxLines: 5,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
