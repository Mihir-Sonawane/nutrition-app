import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nutrition_app/login.dart';

class registerpage extends StatefulWidget {
  const registerpage({super.key});

  @override
  State<registerpage> createState() => _registerpageState();
}

class _registerpageState extends State<registerpage> {
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
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
          "REGISTER",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, size: 20, color: Colors.white),
        ),
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(color: Color(0xff66023c)),
      )
          : Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/register(n).jpg"),
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
                          "Welcome, Start Your Fitness Journey!",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: emailcontroller,
                          validator: (val) {
                            RegExp regex = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                            if (val!.isEmpty) {
                              return "Please Enter Email-id";
                            } else if (!regex.hasMatch(val)) {
                              return "Please enter valid Email-id";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            fillColor: Color(0xFFF5F5F5),
                            hintText: "Enter Your Email-id",
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xff5409DA))),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: phonecontroller,
                          keyboardType: TextInputType.phone,
                          validator: (val) {
                            RegExp regex = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
                            if (val!.isEmpty) {
                              return "Please Enter Phone No";
                            } else if (!regex.hasMatch(val)) {
                              return "Please enter valid Phone No";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                            fillColor: Color(0xFFF5F5F5),
                            hintText: "Enter Your Phone no",
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xff5409DA))),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: passwordcontroller,
                          obscureText: hidepassword,
                          validator: (val) {
                            RegExp regex = RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                            if (val!.isEmpty) {
                              return "Please enter password";
                            } else if (!regex.hasMatch(val)) {
                              return "Please enter valid password";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  hidepassword = !hidepassword;
                                });
                              },
                              child: const Icon(Icons.remove_red_eye),
                            ),
                            fillColor: const Color(0xFFF5F5F5),
                            hintText: "Enter The Password",
                            filled: true,
                            enabledBorder:
                            const OutlineInputBorder(borderSide: BorderSide.none),
                            errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xff5409DA))),
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
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (_) => const loginpage()),
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
                              "SUBMIT",
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

          ],
        ),
      ),
    );
  }
}
