import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/cubit/ongkir/cek_ongkir_cubit.dart';
import '../components/auth_button.dart';
import '../components/textfield.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key, required this.onTap});

  final Function()? onTap;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //controller textfield
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPwController = TextEditingController();

  //register user method
  Future<void> registerUser() async {
    // loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    // konfirmasi passwordnya sama
    if (_passwordController.text != _confirmPwController.text) {
      //loading circle
      Navigator.pop(context);
      // error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password tidak sama"),
        ),
      );
    }

    //register user
    try {
      //registering user
      UserCredential? userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
      //loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //loading circle
      Navigator.pop(context);
      //error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message!),
        ),
      );
    } catch (e) {
      //loading circle
      Navigator.pop(context);
      //error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }

    print("register user");
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
        child: Column(
          children: [
            SizedBox(height: 265),
            SvgPicture.asset(
              'images/postagepro.svg',
            ),
            SizedBox(height: 20),
            MyTextfield(
              controller: _usernameController,
              labelText: "Username",
              obscureText: false,
            ),
            SizedBox(height: 10),
            MyTextfield(
              controller: _emailController,
              labelText: "Email",
              obscureText: false,
            ),
            SizedBox(height: 10),
            MyTextfield(
              controller: _passwordController,
              labelText: "Kata Sandi",
              obscureText: true,
            ),
            SizedBox(height: 10),
            MyTextfield(
              controller: _confirmPwController,
              labelText: "Konfirmasi Kata Sandi",
              obscureText: true,
            ),
            SizedBox(height: 20),
            Text("Lupa Password?"),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: AuthButton(
                text: "Daftar",
                onTap: registerUser,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Sudah punya akun?",
                    style: GoogleFonts.notoSans(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    )),
                Text(" "),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    "Masuk  sekarang!",
                    style: GoogleFonts.notoSans(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF421D54),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
