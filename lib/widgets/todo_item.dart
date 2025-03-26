import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_firebase/controllers/todo_controller.dart';
import 'package:todo_firebase/core/widgets/app_text.dart';
import 'package:todo_firebase/models/todo_model.dart';

class TodoItem extends StatelessWidget {
  final TodoModel todo;
  TodoItem({super.key, required this.todo});
  final TodoController _todoController = Get.find<TodoController>();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: AppText(todo.title),
      subtitle: Text(todo.description),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          // getx confirm dialog
          Get.defaultDialog(
            title: 'ยืนยันการลบ',
            middleText: 'คุณต้องการลบรายการนี้ใช่หรือไม่?',
            textConfirm: 'ใช่',
            textCancel: 'ไม่',
            onConfirm: () {
              if (todo.id == null) return;
              _todoController.deleteTodo(id: todo.id!);
              Get.back();
            },
          );
        },
      ),
      leading: Checkbox(
        value: todo.isDone,
        onChanged: (value) {
          _todoController.updateTodo(todo.copyWith(isDone: value));
        },
      ),
    );
  }
}
