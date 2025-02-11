import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/AppController.dart';
import 'AuthScreen.dart';
import 'SignUpScreen.dart';

class SignInScreen extends StatelessWidget {
  AppController appController = AppController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> signIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      User? user = userCredential.user;

      if (user != null && user.emailVerified) {
        Get.to(AuthScreen());
      } else {
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", "Email or Passwords wrong", backgroundColor: Colors.blue,colorText: Colors.white,messageText: Text("Passwords do not match!",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white),),titleText: Text("Error",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),));
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                // Logo
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue[100],
                  ),
                  child: const Icon(
                    Icons.medication,
                    color: Colors.blue,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Adhicine',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                // Email Field
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email_outlined),

                    hintText: 'jamescordon@gmail.com',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Password Field
                TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: const Icon(Icons.visibility_off_outlined),

                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.blue[400],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Sign In Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      signIn();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('OR'),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image(image: AssetImage('assets/images/google_logo.png'),height: 30,width: 30,),
                      Text("Continue with google",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),)
                    ],
                  ),
                ),
                // const Spacer(),
                // Sign Up Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('New to Adhicine?'),
                    TextButton(
                      onPressed: () {
                        Get.to(SignUpScreen());
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.blue[400],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
