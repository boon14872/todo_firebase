import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_firebase/controllers/auth_controller.dart';
import 'package:todo_firebase/firebase_options.dart';
import 'package:todo_firebase/views/home_view.dart';
import 'package:todo_firebase/views/login_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(
      AuthController(),
      permanent: true,
    );
    return GetMaterialApp(
      title: 'Todo App',
      home: StreamBuilder(
        stream: authController.user.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeView();
          }
          return const LoginView();
        },
      ),
    );
  }
}
