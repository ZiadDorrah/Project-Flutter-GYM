import 'package:flutter/material.dart';
import '../DatabaseHelper.dart';

class EditUserPage extends StatefulWidget {
  final Map<String, dynamic> user;

  EditUserPage({required this.user});

  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.user['username']);
    _passwordController = TextEditingController(text: widget.user['password']);
    _emailController = TextEditingController(text: widget.user['email']);
    _phoneController = TextEditingController(text: widget.user['phone']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                String newUsername = _usernameController.text.trim();
                String newPassword = _passwordController.text.trim();
                String newEmail = _emailController.text.trim();
                String newPhone = _phoneController.text.trim();

                int userId = widget.user['id'] as int;

                await DatabaseHelper.instance.updateUser(
                  userId,
                  newUsername,
                  newPassword,
                  newEmail,
                  newPhone,
                );

                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
