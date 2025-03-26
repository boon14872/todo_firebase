import 'package:flutter/material.dart';
import 'package:todo_firebase/core/constants/app_asset.dart';
import 'package:todo_firebase/core/utils/text_input_formatter.dart';
import 'package:todo_firebase/core/widgets/app_button.dart';
import 'package:todo_firebase/core/widgets/app_text.dart';
import 'package:todo_firebase/core/widgets/app_text_field.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool _nameValid = false;
  bool _surnameValid = false;
  bool _addressValid = false;
  bool _phoneValid = false;
  bool _emailValid = false;

  bool _isSubmitting = false;

  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();
  final TextEditingController _surnameController = TextEditingController();
  final GlobalKey<FormState> _surnameKey = GlobalKey<FormState>();
  final TextEditingController _addressController = TextEditingController();
  final GlobalKey<FormState> _addressKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _phoneKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      if (_nameValid) {
        _nameKey.currentState!.validate();
      } else {
        _nameValid = false;
      }
    });
    _surnameController.addListener(() {
      if (_surnameValid) {
        _surnameKey.currentState!.validate();
      } else {
        _surnameValid = false;
      }
    });
    _addressController.addListener(() {
      if (_addressValid) {
        _addressKey.currentState!.validate();
      } else {
        _addressValid = false;
      }
    });
    _phoneController.addListener(() {
      if (_phoneValid) {
        _phoneKey.currentState!.validate();
      } else {
        _phoneValid = false;
      }
    });
    _emailController.addListener(() {
      if (_emailValid) {
        _emailKey.currentState!.validate();
      } else {
        _emailValid = false;
      }
    });
  }

  Future<void> _onSubmit() async {
    _isSubmitting = true;
    setState(() {});
    if (_nameController.text.isEmpty) {
      _nameValid = true;
    }
    if (_surnameController.text.isEmpty) {
      _surnameValid = true;
    }
    if (_addressController.text.isEmpty) {
      _addressValid = true;
    }
    if (_phoneController.text.isEmpty) {
      _phoneValid = true;
    }
    if (_emailController.text.isEmpty) {
      _emailValid = true;
    }
    final isNameValid = _nameKey.currentState!.validate();
    final isSurnameValid = _surnameKey.currentState!.validate();
    final isAddressValid = _addressKey.currentState!.validate();
    final isPhoneValid = _phoneKey.currentState!.validate();
    final isEmailValid = _emailKey.currentState!.validate();
    if (isNameValid &&
        isSurnameValid &&
        isAddressValid &&
        isPhoneValid &&
        isEmailValid) {
      await Future.delayed(const Duration(seconds: 1));
      resetForm();
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('สมัครสมาชิกสำเร็จ')));
      }
    }
    _isSubmitting = false;
    setState(() {});
  }

  void resetForm() {
    _nameController.clear();
    _surnameController.clear();
    _addressController.clear();
    _phoneController.clear();
    _emailController.clear();
    _nameValid = false;
    _surnameValid = false;
    _addressValid = false;
    _phoneValid = false;
    _emailValid = false;
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
              AppText('สมัครสมาชิก', fontSize: 24, fontWeight: FontWeight.bold),
              const SizedBox(height: 8),
              AppText('กรอกข้อมูลเพื่อสมัครสมาชิก', fontSize: 16),
              const SizedBox(height: 16),
              SizedBox(height: 160, child: Image.asset(AppAsset.imgRegister)),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    AppTextField(
                      formKey: _nameKey,
                      controller: _nameController,
                      label: 'ชื่อ',
                      hint: 'กรอกชื่อ',
                      inputType: TextInputType.text,
                      inputFormatters: [TextOnlyFormatter()],
                      validator: (_) {
                        if (_nameController.text.isEmpty) {
                          return 'กรุณากรอกชื่อ';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      formKey: _surnameKey,
                      controller: _surnameController,
                      label: 'นามสกุล',
                      hint: 'กรอกนามสกุล',
                      inputFormatters: [TextOnlyFormatter()],
                      validator: (_) {
                        if (_surnameController.text.isEmpty) {
                          return 'กรุณากรอกนามสกุล';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      formKey: _addressKey,
                      controller: _addressController,
                      label: 'ที่อยู่',
                      hint: 'กรอกที่อยู่',
                      validator: (_) {
                        if (_addressController.text.isEmpty) {
                          return 'กรุณากรอกที่อยู่';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      formKey: _phoneKey,
                      controller: _phoneController,
                      label: 'เบอร์โทรศัพท์',
                      hint: 'กรอกเบอร์โทรศัพท์',
                      inputType: TextInputType.phone,
                      maxLength: 10,
                      inputFormatters: [NumberOnlyFormatter()],
                      validator: (_) {
                        if (_phoneController.text.isEmpty) {
                          return 'กรุณากรอกเบอร์โทรศัพท์';
                        }
                        if (_phoneController.text.length != 10) {
                          return 'กรุณากรอกเบอร์โทรศัพท์ให้ครบ 10 หลัก';
                        }
                        if (_phoneController.text[0] != '0') {
                          return 'กรุณากรอกเบอร์โทรศัพท์ให้ถูกต้อง';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
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
                    AppButton(
                      onPressed: _isSubmitting ? null : _onSubmit,
                      text: 'สมัครสมาชิก',
                      disabled: _isSubmitting,
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
