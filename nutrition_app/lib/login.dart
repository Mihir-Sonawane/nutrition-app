import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:nutrition_app/home.dart';
import 'package:nutrition_app/register.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final key = GlobalKey<FormState>();
  bool hidepassword = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Color(0xFFD3D3D3)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          "LOG IN",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Color(0xFFD3D3D3)),
        ),
      ),

      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(color: Colors.black),
      )
          : Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 120),
            Expanded(
              child: Form(
                key: key,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Welcome! \nGlad to see you!",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 50),
                        TextFormField(
                          controller: usernamecontroller,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Enter valid Email-Id";
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(val)) {
                              return "Enter a valid email format";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            fillColor: Color(0xFFF5F5F5),
                            hintText: "Email-id",
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: passwordcontroller,
                          obscureText: hidepassword,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "Please enter password";
                            }
                            RegExp regex = RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                            if (!regex.hasMatch(val)) {
                              return "Password must be at least 8 chars, include upper, lower, number & special char";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() => hidepassword = !hidepassword);
                              },
                              child: const Icon(Icons.remove_red_eye,
                                  color: Colors.grey),
                            ),
                            fillColor: const Color(0xFFF5F5F5),
                            hintText: "Enter the password",
                            hintStyle: const TextStyle(color: Colors.grey),
                            filled: true,
                            enabledBorder:
                            const OutlineInputBorder(borderSide: BorderSide.none),
                            errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none),
                          ),
                        ),

                        const SizedBox(height: 24),
                        Container(
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: const LinearGradient(
                              colors: [Colors.black, Color(0xFFD3D3D3)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              if (key.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Login Successful"),
                                      backgroundColor: Colors.black),
                                );
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (_) =>  HomePage()),
                                      (route) => false,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text(
                              "LOGIN",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFD3D3D3)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => registerpage()));
                },
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFFD3D3D3),Colors.black, ],
                  ).createShader(bounds),
                  child: const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
