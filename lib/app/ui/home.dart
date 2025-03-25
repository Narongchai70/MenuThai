import 'package:app_manu_thai/app/data/food.dart';
import 'package:app_manu_thai/app/ui/menu.dart';
import 'package:flutter/material.dart';

class HomeScreenState extends StatefulWidget {
  const HomeScreenState({super.key});

  @override
  State<HomeScreenState> createState() => _HomeScreenStateState();
}

class _HomeScreenStateState extends State<HomeScreenState> {
  TextEditingController _searchController = TextEditingController();
  List<Map> foodList = [];
  List<Map> originalFoodList = [];

  @override
  void initState() {
    super.initState();
    originalFoodList = foodJson['thai_foods'] ?? [];
    foodList = List.from(originalFoodList);

    _searchController.addListener(() {
      _filterFoodList(_searchController.text);
    });
  }

  void _filterFoodList(String query) {
    setState(() {
      if (query.isEmpty) {
        foodList = List.from(originalFoodList);
      } else {
        foodList =
            originalFoodList
                .where((e) => '${e['menu_name']}'.contains(query))
                .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade500),
                    ),
                    hintText: 'ค้นหาอาหาร',
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemCount: foodList.length,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Menu(data: foodList[index]),
                            ),
                          );
                        },
                        child: Container(
                          height: 220,
                          width: double.infinity,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${foodList[index]['chef']['name']}',
                                        maxLines: 1,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(color: Colors.grey),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '${foodList[index]['menu_name']}',
                                        maxLines: 2,
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.headlineMedium,
                                      ),
                                      Text(
                                        '${foodList[index]['ingredients']}',
                                        maxLines: 3,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Hero(
                                  tag: foodList[index]['image_url'],
                                  child: Image.network(
                                    '${foodList[index]['image_url']}',

                                    fit: BoxFit.cover,
                                    height: 220,
                                    loadingBuilder: (
                                      context,
                                      child,
                                      loadingProgress,
                                    ) {
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
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
