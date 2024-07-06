import 'package:flutter/material.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  bool _errorText = false;
  bool focusTextUsername = false;
  bool focusTextPassword = false;
  bool focusTextConfirmPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/logo.png",
                width: 250,
              ),
              TextField(
                controller: username,
                onChanged: (value) {
                  setState(() {
                    focusTextUsername = true;
                  });
                },
                onEditingComplete: () {
                  setState(() {
                    focusTextUsername = false;
                  });
                },
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  labelText: "Username",
                  labelStyle: TextStyle(
                    color: focusTextUsername ? Colors.red : Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              TextField(
                controller: password,
                onChanged: (value) {
                  setState(() {
                    focusTextPassword = true;
                  });
                },
                onEditingComplete: () {
                  setState(() {
                    _errorText = false;
                    focusTextPassword = false;
                  });
                },
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  labelText: "Password",
                  labelStyle: TextStyle(
                    color: focusTextPassword ? Colors.red : Colors.white,
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20,),
              TextField(
                controller: confirmPassword,
                onChanged: (value) {
                  setState(() {
                    focusTextConfirmPassword = true;
                  });
                },
                onEditingComplete: () {
                  setState(() {
                    _errorText = false;
                    focusTextConfirmPassword = false;
                  });
                },
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  labelText: "Confirm Password",
                  labelStyle: TextStyle(
                    color: focusTextConfirmPassword || _errorText ? Colors.red : Colors.white,
                  ),
                  errorText: _errorText ? "Unmatched password" : null,
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (password.text == confirmPassword.text) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const MyHomePage()),
                      );
                    } else {
                      _errorText = true;
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(25),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Sign Up"),
                  ],
                ),
              ),
              const SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                    child: const Text(
                      "Log In",
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
