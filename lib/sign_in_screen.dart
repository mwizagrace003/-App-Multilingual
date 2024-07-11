import 'package:flutter/material.dart';
import 'home_screen.dart';

class SignInScreen extends StatefulWidget {
  final bool isDarkMode;

  const SignInScreen({super.key, required this.isDarkMode});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _signIn() {
    // Navigate to the home screen or show a success message
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => HomeScreen(onThemeChanged: (ThemeMode) {}, onLanguageChanged: (Locale) {}, contacts: [], onUpdateProfileImage: (XFile) {}, profileImage: null,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isDarkMode ? Colors.black : Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(70.0),
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.login_outlined,
                    color: widget.isDarkMode ? Colors.white : Colors.deepPurple,
                    size: 60.0,
                  ),
                  const SizedBox(height: 50),
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
                  const SizedBox(height: 40),
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
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _signIn();
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        widget.isDarkMode ? Colors.grey[800] : Colors.deepPurple,
                      ),
                    ),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(fontSize: 25.0, color: Colors.white),
                    ),
                  ),
                  // Add social media sign-in buttons here if needed
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
    super.dispose();
  }
}
