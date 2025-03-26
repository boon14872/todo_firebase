import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_firebase/controllers/todo_controller.dart';
import 'package:todo_firebase/core/widgets/app_button.dart';
import 'package:todo_firebase/core/widgets/app_text_field.dart';

class AddTodoSection extends StatefulWidget {
  const AddTodoSection({super.key});

  @override
  State<AddTodoSection> createState() => _AddTodoSectionState();
}

class _AddTodoSectionState extends State<AddTodoSection> {
  final TodoController _todoController = Get.find<TodoController>();

  final TextEditingController _titleController = TextEditingController();
  final GlobalKey<FormState> _titleKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _descriptionKey = GlobalKey<FormState>();

  bool _titleValid = false;
  bool _descriptionValid = false;

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _titleController.addListener(() {
      if (_titleValid) {
        _titleKey.currentState!.validate();
      } else {
        _titleValid = false;
      }
    });
    _descriptionController.addListener(() {
      if (_descriptionValid) {
        _descriptionKey.currentState!.validate();
      } else {
        _descriptionValid = false;
      }
    });
  }

  Future<void> _onSubmit() async {
    _isSubmitting = true;
    setState(() {});
    if (_titleController.text.isEmpty) {
      _titleValid = true;
    }
    if (_descriptionController.text.isEmpty) {
      _descriptionValid = true;
    }

    final isTitleValid = _titleKey.currentState!.validate();
    final isDescriptionValid = _descriptionKey.currentState!.validate();

    if (isTitleValid && isDescriptionValid) {
      await _todoController.addTodo(
        title: _titleController.text,
        description: _descriptionController.text,
      );
      _titleController.clear();
      _descriptionController.clear();
      _titleValid = false;
      _descriptionValid = false;
      if (mounted) {
        FocusScope.of(context).unfocus();
      }
    }
    _isSubmitting = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        AppTextField(
          label: 'ชื่อรายการ',
          controller: _titleController,
          formKey: _titleKey,
          validator: (value) {
            if (_titleController.text.isEmpty) {
              return 'กรุณากรอกชื่อรายการ';
            }
            return null;
          },
        ),
        SizedBox(height: 16),
        AppTextField(
          label: 'รายละเอียด',
          controller: _descriptionController,
          formKey: _descriptionKey,
          validator: (value) {
            if (_descriptionController.text.isEmpty) {
              return 'กรุณากรอกรายละเอียด';
            }
            return null;
          },
        ),
        SizedBox(height: 16),
        AppButton(
          onPressed: _isSubmitting ? null : _onSubmit,
          text: _isSubmitting ? 'กำลังเพิ่ม...' : 'เพิ่ม',
          color: Colors.black,
        ),
      ],
    );
  }
}
