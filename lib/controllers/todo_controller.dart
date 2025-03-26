import 'package:get/get.dart';
import 'package:todo_firebase/controllers/auth_controller.dart';
import 'package:todo_firebase/core/constants/app_keys.dart';
import 'package:todo_firebase/core/widgets/app_snackbar.dart';
import 'package:todo_firebase/models/todo_model.dart';
import 'package:todo_firebase/services/firebase_service.dart';

class TodoController extends GetxController {
  final RxList<TodoModel> todos = <TodoModel>[].obs;
  final RxBool isLoading = false.obs;

  final FirebaseService _firebaseService = FirebaseService();
  final AuthController _authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    fetchTodos();
  }

  Future<void> fetchTodos() async {
    isLoading.value = true;
    try {
      final List<TodoModel> todos = await _firebaseService.getData<TodoModel>(
        AppKeys.todoCollection,
        fromJson: (doc) => TodoModel.fromDocumentSnapshot(doc),
        uid: _authController.user.value!.uid,
      );
      this.todos.assignAll(todos);
    } catch (e) {
      showSnackBar(message: e.toString(), title: 'ไม่สามารถดึงข้อมูลได้');
    }
    isLoading.value = false;
  }

  Future<void> addTodo({
    required String title,
    required String description,
  }) async {
    isLoading.value = true;
    try {
      final TodoModel todo = TodoModel(
        title: title,
        description: description,
        uid: _authController.user.value!.uid,
      );
      await _firebaseService.addData(AppKeys.todoCollection, todo.toJson());
      fetchTodos();
      showSnackBar(title: 'สำเร็จ', message: 'เพิ่มข้อมูลสำเร็จ');
    } catch (e) {
      showSnackBar(title: 'ไม่สามารถเพิ่มข้อมูลได้', message: e.toString());
    }
    isLoading.value = false;
  }

  Future<void> updateTodo(TodoModel todo) async {
    isLoading.value = true;
    try {
      if (todo.title.isEmpty || todo.description.isEmpty) {
        showSnackBar(
          title: 'ไม่สามารถอัพเดทข้อมูลได้',
          message: 'กรุณากรอกข้อมูลให้ครบ',
        );
        return;
      }
      if (todo.id == null) {
        showSnackBar(
          title: 'ไม่สามารถอัพเดทข้อมูลได้',
          message: 'ไม่พบ ID ของข้อมูล',
        );
        return;
      }
      await _firebaseService.updateData(
        AppKeys.todoCollection,
        todo.id!,
        todo.toJson(),
      );
      fetchTodos();
      showSnackBar(title: 'สำเร็จ', message: 'อัพเดทข้อมูลสำเร็จ');
    } catch (e) {
      showSnackBar(title: 'ไม่สามารถอัพเดทข้อมูลได้', message: e.toString());
    }
    isLoading.value = false;
  }

  Future<void> deleteTodo({required String id}) async {
    isLoading.value = true;
    try {
      await _firebaseService.deleteData(AppKeys.todoCollection, id);
      fetchTodos();
      showSnackBar(title: 'สำเร็จ', message: 'ลบข้อมูลสำเร็จ');
    } catch (e) {
      showSnackBar(title: 'ไม่สามารถลบข้อมูลได้', message: e.toString());
    }
    isLoading.value = false;
  }
}
