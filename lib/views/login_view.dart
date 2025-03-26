import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_firebase/controllers/auth_controller.dart';
import 'package:todo_firebase/core/constants/app_asset.dart';
import 'package:todo_firebase/core/widgets/app_button.dart';
import 'package:todo_firebase/core/widgets/app_text.dart';
import 'package:todo_firebase/core/widgets/app_text_field.dart';
import 'package:todo_firebase/views/home_view.dart';
import 'package:todo_firebase/views/register_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final AuthController _authController = Get.find<AuthController>();

  bool _emailValid = false;
  bool _passwordValid = false;

  bool _isSubmitting = false;

  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _passwordKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (_authController.user.value != null) {
      Get.offAll(() => HomeView());
    }
    super.initState();
    _addListeners();
  }

  void _addListeners() {
    _emailController.addListener(() {
      if (_emailValid) {
        _emailKey.currentState!.validate();
      } else {
        _emailValid = false;
      }
    });
    _passwordController.addListener(() {
      if (_passwordValid) {
        _passwordKey.currentState!.validate();
      } else {
        _passwordValid = false;
      }
    });
  }

  Future<void> _onSubmit() async {
    _isSubmitting = true;
    setState(() {});
    if (_emailController.text.isEmpty) {
      _emailValid = true;
    }
    if (_passwordController.text.isEmpty) {
      _passwordValid = true;
    }

    final isEmailValid = _emailKey.currentState!.validate();
    final isPasswordValid = _passwordKey.currentState!.validate();
    if (isEmailValid && isPasswordValid) {
      await _authController.login(
        _emailController.text,
        _passwordController.text,
      );
      if (_authController.user.value != null) {
        Get.offAll(() => HomeView());
      }
      resetForm();
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('เข้าสู่ระบบสำเร็จ')));
      }
    }
    _isSubmitting = false;
    setState(() {});
  }

  void resetForm() {
    _emailController.clear();
    _passwordController.clear();
    _emailValid = false;
    _passwordValid = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.black),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              AppText('เข้าสู่ระบบ', fontSize: 24, fontWeight: FontWeight.bold),
              const SizedBox(height: 8),
              AppText('กรอกข้อมูลเพื่อเข้าสู่ระบบ', fontSize: 16),
              const SizedBox(height: 16),
              SizedBox(height: 160, child: Image.asset(AppAsset.imgRegister)),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    AppTextField(
                      formKey: _emailKey,
                      controller: _emailController,
                      label: 'อีเมล',
                      hint: 'กรอกอีเมล',
                      inputType: TextInputType.emailAddress,
                      validator: (_) {
                        if (_emailController.text.isEmpty) {
                          return 'กรุณากรอกอีเมล';
                        }
                        if (!_emailController.text.contains('@')) {
                          return 'กรุณากรอกอีเมลให้ถูกต้อง';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      formKey: _passwordKey,
                      controller: _passwordController,
                      label: 'รหัสผ่าน',
                      hint: 'กรอกรหัสผ่าน',
                      isObscure: true,
                      validator: (_) {
                        if (_passwordController.text.isEmpty) {
                          return 'กรุณากรอกรหัสผ่าน';
                        }
                        if (_passwordController.text.length < 6) {
                          return 'กรุณากรอกรหัสผ่านมากกว่า 6 ตัวอักษร';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    AppButton(
                      onPressed: _isSubmitting ? null : _onSubmit,
                      text: 'เข้าสู่ระบบ',
                      disabled: _isSubmitting,
                    ),
                    const SizedBox(height: 16),
                    AppText('หากยังไม่มีบัญชีผู้ใช้ กรุณาสมัครสมาชิก'),
                    const SizedBox(height: 16),
                    AppButton(
                      onPressed: () => Get.to(() => const RegisterView()),
                      text: 'สมัครสมาชิก',
                      color: Colors.green.shade500,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
