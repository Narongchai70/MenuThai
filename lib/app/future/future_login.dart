import 'package:flutter/material.dart';

class FutureLogin extends StatefulWidget {
  const FutureLogin({super.key});

  @override
  State<FutureLogin> createState() => _FutureLoginState();
}

class _FutureLoginState extends State<FutureLogin> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<bool>? loginFuture;

  Future<bool> login(String username, String password) async {
    await Future.delayed(Duration(seconds: 2));
    return username == 'admin' && password == '1234';
  }

  void _handleLogin() {
    setState(() {
      loginFuture = login(usernameController.text, passwordController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ระบบล็อกอิน')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _handleLogin,
              child: const Text('เข้าสู่ระบบ'),
            ),
            const SizedBox(height: 20),

            if (loginFuture != null)
              FutureBuilder<bool>(
                future: loginFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                    if (snapshot.data == true) {
                      return const Text('เข้าสู่ระบบสำเร็จ!');
                    } else {
                      return const Text('เข้าสู่ระบบล้มเหลว');
                    }
                  } else if (snapshot.hasError) {
                    return Text('เกิดข้อผิดพลาด: ${snapshot.error}');
                  }
                  return const SizedBox();
                },
              ),
          ],
        ),
      ),
    );
  }
}
