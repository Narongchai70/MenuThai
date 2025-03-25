import 'package:app_manu_thai/app/future/future_delayed.dart';
import 'package:app_manu_thai/app/future/future_login.dart';
import 'package:app_manu_thai/app/future/future_lord_data.dart';
import 'package:app_manu_thai/app/future/future_lord_item.dart';
import 'package:app_manu_thai/app/stream/number.dart';
import 'package:app_manu_thai/app/stream/stream_number_start.dart';
import 'package:app_manu_thai/app/stream/stream_countdown.dart';
import 'package:app_manu_thai/app/stream/stream_random.dart';
import 'package:app_manu_thai/app/stream/stream_time_messages.dart';
import 'package:app_manu_thai/app/ui/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Home());
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreenState());
  }
}
