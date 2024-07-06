import 'package:flutter/material.dart';
import 'package:flutter_application_1/forgot_password.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/signup.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  bool _errorText = false;
  bool focusTextUsername = false;
  bool focusTextPassword = false;

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
                    _errorText = false;
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
                    color: focusTextUsername || _errorText
                        ? Colors.red
                        : Colors.white,
                  ),
                  errorText: _errorText ? "Incorrect username or password" : null,
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
                    color: focusTextPassword || _errorText
                        ? Colors.red
                        : Colors.white,
                  ),
                  errorText: _errorText ? "Incorrect username or password" : null,
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (username.text == "riyando" && password.text == "123") {
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
                  children: [Text("Log In")],
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const ForgotPasswordPage()),
                  );
                },
                style: ButtonStyle(
                  alignment: Alignment.centerRight, 
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "OR",
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                ],
              ),
              const SizedBox(height: 30),
              Image.asset(
                "assets/google.png",
                width: 50,
              ),
              const SizedBox(width: 10),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const SignUpPage()),
                      );
                    },
                    child: const Text(
                      "Sign Up",
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
