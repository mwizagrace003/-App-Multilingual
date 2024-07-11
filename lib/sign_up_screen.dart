import 'sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SignUpScreen extends StatefulWidget {
  final bool isDarkMode;

  const SignUpScreen({super.key, required this.isDarkMode});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  DateTime? _date;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  Future<Null> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date ?? DateTime(DateTime.now().year - 50),
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _date) {
      setState(() {
        _date = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: widget.isDarkMode ? Colors.black : Colors.white60,
        body: Padding(
        padding: const EdgeInsets.all(40.0),
    child: SingleChildScrollView(
    child: Center(
    child: Form(
    key: _formKey,
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    Icon(
    Icons.app_registration,
    color: Colors.deepPurple,
    size: 70.0,
    ),
    const SizedBox(height: 50),
    TextFormField(
    controller: _fullNameController,
    style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black),
    decoration: InputDecoration(
    labelText: "Full Name",
    labelStyle: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black),
    ),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter your full name';
    }
    return null;
    },
    ),
    const SizedBox(height: 10),
    TextFormField(
    controller: _usernameController,
    style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black),
    decoration: InputDecoration(
    labelText: "Username",
    labelStyle: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black),
    ),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter a username';
    }
    return null;
    },
    ),
    const SizedBox(height: 20),
    TextFormField(
    controller: _emailController,
    style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black),
    decoration: InputDecoration(
    labelText: "Email",
    labelStyle: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black),
    ),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter your email';
    }
    if (!value.contains('@')) {
    return 'Please enter a valid email';
    }
    return null;
    },
    ),
    const SizedBox(height: 20),
    TextFormField(
    controller: _passwordController,
    obscureText: true,
    style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black),
    decoration: InputDecoration(
    labelText: "Password",
    labelStyle: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black),
    ),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter a password';
    }
    if (value.length < 6) {
    return 'Password must be at least 6 characters';
    }
    return null;
    },
    ),
    const SizedBox(height: 20),
    TextFormField(
    controller: _phoneNumberController,
    keyboardType: TextInputType.phone,
    style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black),
    decoration: InputDecoration(
    labelText: "Telephone Number",
    labelStyle: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black),
    ),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter your phone number';
    }
    return null;
    },
    ),
    GestureDetector(
    onTap: () => selectDate(context),
    child: AbsorbPointer(
    child: TextFormField(
    controller: TextEditingController(
    text: _date != null ? DateFormat('yyyy-MM-dd').format(_date!) : '',
    ),
    style: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black),
    decoration: InputDecoration(
    labelText: 'Date of Birth',
    labelStyle: TextStyle(color: widget.isDarkMode ? Colors.white : Colors.black),
    ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your date of birth';
        }
        return null;
      },
    ),
    ),
    ),
      const SizedBox(height: 30),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Navigate to the next screen or show a success message
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SignInScreen(isDarkMode: widget.isDarkMode),
              ),
            );
          }
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            widget.isDarkMode ? Colors.grey[800] : Colors.deepPurple,
          ),
        ),
        child: const Text(
          'Sign Up',
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
      ),
    ],
    ),
    ),
    ),
    ),
        ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    _usernameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }
}
