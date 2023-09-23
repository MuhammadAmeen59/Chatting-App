import 'dart:convert';

import 'package:chattingapp/home.dart';
import 'package:chattingapp/sign.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailLoginController = TextEditingController();
  TextEditingController _passwordLoginController = TextEditingController();

  toast(String title) {
    return showToast(
      title,
      context: context,
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.center,
      animDuration: Duration(milliseconds: 500),
      duration: Duration(seconds: 2),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
    );
  }

login(context) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  try {
    // ignore: unused_local_variable
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailLoginController.text,
      password: _passwordLoginController.text,
    );
    _prefs.setString("UserDetails", json.encode(_emailLoginController.text));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home()));
    toast("Successfully Logged In");
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      toast("Weak Password, Try Again");
    } else if (e.code == 'email-already-in-use') {
      toast("Email Already in Use");
    } else if (e.code == 'user-not-found' || e.code == 'wrong-password') {
      // Clear the text controllers if login is unsuccessful
      _emailLoginController.clear();
      _passwordLoginController.clear();
      toast("Invalid Credentials");
    }
  } catch (e) {
    print(e);
  }
}





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFF6B6B),
              Color(0xFFFF6B6B),
              Color(0xFFFF977F),
              Color(0xFFFFCDA0),
            ],
            stops: [0.1, 0.4, 0.7, 0.9],
          ),
        ),
        child: Center( // Center the content vertically and horizontally
          child: SingleChildScrollView( // To make content scrollable if it overflows
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 18,
                ),
                const Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    textDirection: TextDirection.ltr,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Log In',
                        style: TextStyle(
                          color: Colors.black, // Black text color
                          fontSize: 27,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: SizedBox(
                    height: 56,
                    child: TextField(
                      controller: _emailLoginController,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white70, // Faded white
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.mail_outline_rounded,
                          color: Colors.black, // Black icon color
                          size: 20,
                        ),
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Color(0xFFB2B2B2), // Faded light navy blue
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.black, // Black border
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.black, // Black border
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: SizedBox(
                    height: 56,
                    child: TextField(
                      controller: _passwordLoginController,
                      textAlign: TextAlign.center,
                      obscureText: true,
                      style: const TextStyle(
                        color: Colors.white70, // Faded white
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.visibility_off_outlined,
                          color: Colors.black, // Black icon color
                          size: 20,
                        ),
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: Color(0xFFB2B2B2), // Faded light navy blue
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.black, // Black border
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.black, // Black border
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: SizedBox(
                      width: 329,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_emailLoginController.text != "" &&
                              _passwordLoginController.text != "") {
                            login(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Home(),
                                ));
                          } else {
                            toast("Required Fields are Empty");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFF6B6B), // Red
                        ),
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                            color: Colors.white, // White text color
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 138,),
                  child: Row(
                    children: [
                      const Text(
                        'No account?',
                        style: TextStyle(
                          color: Colors.black, // Black text color
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 2.5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SignUp();
                          }));
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white, // Black text color
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
