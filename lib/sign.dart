import 'package:chattingapp/log.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _emailSignUpController = TextEditingController();
  TextEditingController _passwordSignUpController = TextEditingController();

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

  signup(context) async {
    try {
      // ignore: unused_local_variable
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailSignUpController.text,
        password: _passwordSignUpController.text,
      );
      toast("Successfully Signed Up");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        toast("Weak Password, Try Again");
      } else if (e.code == 'email-already-in-use') {
        toast("Email Already In Use");
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
        child: Center(
          child: SingleChildScrollView(
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
                        'Sign up',
                        style: TextStyle(
                          color: Colors.black,
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
                      controller: _emailSignUpController,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white70, // Faded white
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.mail,
                          color: Colors.black,
                          size: 20,
                        ),
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Color(0xFFB2B2B2),
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
                      controller: _passwordSignUpController,
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
                          color: Colors.black,
                          size: 20,
                        ),
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: Color(0xFFB2B2B2),
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
                          if (_emailSignUpController.text != "" &&
                              _passwordSignUpController.text != "") {
                            signup(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ));
                          } else {
                            toast("Required Fields are Empty");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFF6B6B),
                        ),
                        child: const Text(
                          'Create Account',
                          style: TextStyle(
                            color: Colors.white, // Faded white
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
                  padding: const EdgeInsets.symmetric(horizontal: 115),
                  child: Row(
                    children: [
                      const Text(
                        'Have an account?',
                        style: TextStyle(
                          color: Colors.black,
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
                            return Login();
                          }));
                        },
                        child: const Text(
                          'Log In Now',
                          style: TextStyle(
                            color: Colors.white,
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
