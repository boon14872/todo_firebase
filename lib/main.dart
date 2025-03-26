import 'package:flutter/material.dart';
import 'package:todo_firebase/views/register_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      home: const RegisterView(),
    );
  }
}
