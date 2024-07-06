import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController userInputController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool _errorText = false;
  bool _isPhoneNumber = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
        backgroundColor: Colors.black12,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/pesan1.png', 
                height: 300,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isPhoneNumber = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isPhoneNumber ? Colors.blue.shade300 : Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: const Text("Phone Number"),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isPhoneNumber = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: !_isPhoneNumber ? Colors.blue.shade300 : Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    child: const Text("Email"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: userInputController,
                decoration: InputDecoration(
                  hintText: _isPhoneNumber ? "Enter your phone number" : "Enter your email",
                  hintStyle: TextStyle(color: Colors.black38), 
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),  
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black), 
                  ),
                  labelText: _isPhoneNumber ? "Phone Number" : "Email",
                  labelStyle: TextStyle(
                    color: _errorText ? Colors.red : Colors.black,  
                  ),
                  errorText: _errorText ? "Please enter a valid ${_isPhoneNumber ? 'phone number' : 'email'}" : null,
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red), 
                  ),
                ),
                keyboardType: _isPhoneNumber ? TextInputType.phone : TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: newPasswordController,
                decoration: InputDecoration(
                  hintText: "Enter new password",
                  hintStyle: TextStyle(color: Colors.black38),  
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black), 
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black), 
                  ),
                  labelText: "New Password",
                  labelStyle: TextStyle(
                    color: Colors.black,  
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  hintText: "Confirm new password",
                  hintStyle: TextStyle(color: Colors.black38),  
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),  
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),  
                  ),
                  labelText: "Confirm Password",
                  labelStyle: TextStyle(
                    color: Colors.black,  
                  ),
                  errorText: _errorText ? "Passwords do not match" : null,
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),  
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_validateInput()) {
                      _sendResetCode(userInputController.text);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Reset code sent!")),
                      );
                    } else {
                      _errorText = true;
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(25),
                ),
                child: const Text("Send Reset Code"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _validateInput() {
    if (_isPhoneNumber) {
      return userInputController.text.isNotEmpty &&
          newPasswordController.text.isNotEmpty &&
          confirmPasswordController.text.isNotEmpty &&
          newPasswordController.text == confirmPasswordController.text;
    } else {
      final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
      return regex.hasMatch(userInputController.text) &&
          newPasswordController.text.isNotEmpty &&
          confirmPasswordController.text.isNotEmpty &&
          newPasswordController.text == confirmPasswordController.text;
    }
  }

  void _sendResetCode(String userInput) {
    String resetCode = _generateRandomCode(); 

    if (_isPhoneNumber) {
      print("Sending SMS to $userInput with reset code: $resetCode");
    } else {
      print("Sending email to $userInput with reset code: $resetCode");
    }
  }

  String _generateRandomCode() {
    return "123456"; 
  }
}
