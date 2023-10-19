import 'package:cek_ongkir/controller/cubit/ongkir/cek_ongkir_cubit.dart';
import 'package:cek_ongkir/view/components/auth_button.dart';
import 'package:cek_ongkir/view/components/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key, required this.onTap});

  final Function()? onTap;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //controller textfield
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  //sign user method
  Future<void> signInUser() async {
    //loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    //sign in user
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      //loading circle
      if (context.mounted) Navigator.pop(context);
    }
    //display error
    on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password Salah"),
        ),
      );
    }
    print("sign in user");
  }

  @override
  void dispose() {
    CekOngkirCubit().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(height: 265.h),
              SvgPicture.asset(
                'images/postagepro.svg',
              ),
              const SizedBox(height: 20),
              MyTextfield(
                controller: _emailController,
                labelText: "Email",
                obscureText: false,
              ),
              const SizedBox(height: 10),
              MyTextfield(
                controller: _passwordController,
                labelText: "Password",
                obscureText: true,
              ),
              const SizedBox(height: 20),
              const Text("Lupa Password?"),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: AuthButton(
                  text: "Masuk",
                  onTap: signInUser,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Belum punya akun?",
                      style: GoogleFonts.notoSans(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      )),
                  const Text(" "),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      "Daftar sekarang!",
                      style: GoogleFonts.notoSans(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF421D54),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
