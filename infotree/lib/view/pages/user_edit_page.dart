import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:infotree/model/data.dart';
import 'package:infotree/model/user_data.dart';
import 'package:flutter/cupertino.dart';

class UserEditPage extends StatefulWidget {
  @override
  _UserEditPageState createState() => _UserEditPageState();
}

class _UserEditPageState extends State<UserEditPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _schoolController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _majorController;

  String _selectedGender = 'male';
  int _selectedGrade = 1;
  int _selectedYear = 2022;

  @override
  void initState() {
    super.initState();
    final user = Provider.of<Data>(context, listen: false).user;
    _nameController = TextEditingController(text: user.name);
    _schoolController = TextEditingController(text: user.school);
    _emailController = TextEditingController(text: user.email);
    _phoneController = TextEditingController(text: user.phone);
    _majorController = TextEditingController(text: user.major.join(', '));
    _selectedGender = user.gender;
    _selectedGrade = user.grade;
    _selectedYear = user.year;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _schoolController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _majorController.dispose();
    super.dispose();
  }

  void _showCupertinoPicker({
    required BuildContext context,
    required int initialIndex,
    required int itemCount,
    required String title,
    required String Function(int) itemLabelBuilder,
    required void Function(int) onItemSelected,
  }) {
    showCupertinoModalPopup(
      context: context,
      builder:
          (_) => Container(
            height: 250,
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: const Text(
                      '완료',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Expanded(
                  child: CupertinoPicker(
                    scrollController: FixedExtentScrollController(
                      initialItem: initialIndex,
                    ),
                    itemExtent: 32.0,
                    onSelectedItemChanged: onItemSelected,
                    children: List<Widget>.generate(itemCount, (index) {
                      return Center(
                        child: Text(
                          itemLabelBuilder(index),
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) return '이름을 입력해주세요';
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return '이메일을 입력해주세요';
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) return '유효한 이메일 형식이 아닙니다';
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) return '전화번호를 입력해주세요';
    if (!RegExp(r'^\d{10,11}$').hasMatch(value)) return '유효한 전화번호가 아닙니다';
    return null;
  }

  void _saveChanges() {
    if (_formKey.currentState?.validate() ?? false) {
      final updatedUser = UserData(
        id: Provider.of<Data>(context, listen: false).user.id,
        name: _nameController.text,
        school: _schoolController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        major: _majorController.text.split(', '),
        channel: Provider.of<Data>(context, listen: false).user.channel,
        categories: Provider.of<Data>(context, listen: false).user.categories,
        likes: Provider.of<Data>(context, listen: false).user.likes,
        year: _selectedYear,
        gender: _selectedGender,
        grade: _selectedGrade,
      );

      Provider.of<Data>(context, listen: false).user = updatedUser;
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('프로필 수정')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildTextField(_nameController, '이름', _validateName),
              buildTextField(_schoolController, '학교'),
              buildTextField(_emailController, '이메일', _validateEmail),
              buildTextField(_phoneController, '전화번호', _validatePhone),
              buildTextField(_majorController, '전공'),
              const SizedBox(height: 12),
              const Text(
                '성별',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    const Text('남성', style: TextStyle(color: Colors.black)),
                    Radio<String>(
                      value: 'male',
                      groupValue: _selectedGender,
                      onChanged:
                          (value) => setState(() => _selectedGender = value!),
                    ),
                    const Text('여성', style: TextStyle(color: Colors.black)),
                    Radio<String>(
                      value: 'female',
                      groupValue: _selectedGender,
                      onChanged:
                          (value) => setState(() => _selectedGender = value!),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                '학년',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              CupertinoButton(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    Text(
                      '$_selectedGrade 학년',
                      style: const TextStyle(color: Colors.black),
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                      size: 20,
                    ),
                  ],
                ),
                onPressed: () {
                  _showCupertinoPicker(
                    title: '',
                    context: context,
                    initialIndex: _selectedGrade - 1,
                    itemCount: 5,
                    itemLabelBuilder: (i) => '${i + 1}학년',
                    onItemSelected:
                        (i) => setState(() => _selectedGrade = i + 1),
                  );
                },
              ),
              const SizedBox(height: 12),
              const Text(
                '출생연도',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              CupertinoButton(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    Text(
                      '$_selectedYear년',
                      style: const TextStyle(color: Colors.black),
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                      size: 20,
                    ),
                  ],
                ),
                onPressed: () {
                  _showCupertinoPicker(
                    title: '',
                    context: context,
                    initialIndex: _selectedYear - 1995,
                    itemCount: 26,
                    itemLabelBuilder: (i) => '${1995 + i}년',
                    onItemSelected:
                        (i) => setState(() => _selectedYear = 1995 + i),
                  );
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _saveChanges, child: const Text('저장')),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
    TextEditingController controller,
    String label, [
    String? Function(String?)? validator,
  ]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: Colors.black,
          ),
        ),
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
