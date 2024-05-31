import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:red_wine/screens/sign_in_screen.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        color: Colors.yellow, // Ganti dengan gambar latar belakang nanti
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 32.0),
                    Image.asset(
                      'assets/logo.png', // Ganti dengan path logo Anda
                      height: 100,
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Selamat Datang di PempekGO',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 16.0),
                    // TextField(
                    //   controller: _confirmPasswordController,
                    //   decoration: const InputDecoration(
                    //     labelText: 'Konfirmasi Password',
                    //     filled: true,
                    //     fillColor: Colors.white,
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    //     ),
                    //   ),
                    //   obscureText: true,
                    // ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: _usernameController.text,
                            password: _passwordController.text,
                          );
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const SignInScreen()),
                          );
                        } catch (error) {
                          setState(() {
                            _errorMessage = error.toString();
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(_errorMessage),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50.0, vertical: 15.0), 
                            backgroundColor: Colors.green, // Warna tombol login
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text('Sign Up'),
                    ),
                    const SizedBox(height: 16.0),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignInScreen()),
                        );
                      },
                      child: const Text(
                        'Already have an account? Sign in',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 162.0),
                  ],
                ),
                const Text(
                  'By Kelompok Pempek RedWine',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
