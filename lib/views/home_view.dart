import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_firebase/controllers/auth_controller.dart';
import 'package:todo_firebase/controllers/todo_controller.dart';
import 'package:todo_firebase/core/widgets/app_text.dart';
import 'package:todo_firebase/views/login_view.dart';
import 'package:todo_firebase/widgets/add_todo_section.dart';
import 'package:todo_firebase/widgets/todo_item.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final AuthController _authController = Get.find<AuthController>();
  final TodoController _todoController = Get.put(TodoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText('Todo App', color: Colors.white),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    'ยินดีต้อนรับ ${_authController.user.value!.email}',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  TextButton(
                    onPressed: () async {
                      await _authController.logout();
                      Get.offAll(() => LoginView());
                    },
                    child: AppText('ออกจากระบบ', color: Colors.red),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              AppText('เพิ่มรายการ', fontSize: 24, fontWeight: FontWeight.bold),
              AddTodoSection(),
              const SizedBox(height: 16),
              AppText(
                'รายการที่ต้องทำ',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 16),
              Obx(
                () =>
                    _todoController.todos.isEmpty
                        ? AppText('ไม่มีรายการที่ต้องทำ')
                        : Column(
                          children:
                              _todoController.todos
                                  .map((todo) => TodoItem(todo: todo))
                                  .toList(),
                        ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
