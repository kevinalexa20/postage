import 'package:cek_ongkir/view/components/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroPage extends StatelessWidget {
  IntroPage({super.key});

  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: size.width,
        height: size.height,
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            //LOGO
            children: [
              SizedBox(
                height: 115.h,
              ),
              SvgPicture.asset(
                'images/postagepro.svg',
                // fit: BoxFit.none,
              ),
              //IMAGE
              SizedBox(
                height: 37.h,
              ),
              Image.asset(
                'images/splashpic.png',
                width: 428.w,
                height: 427.h,
                fit: BoxFit.none,
              ),
              SizedBox(
                height: 42.h,
              ),
              //TEXT
              Container(
                alignment: Alignment.center,
                // width: 1000.w,
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  'Cara termudah temukan ongkirmu',
                  style: GoogleFonts.notoSans(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF421D54),
                  ),
                  textScaleFactor: 0.8,
                ),
              ),
              SizedBox(
                height: 60.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: AuthButton(
                  text: "Mulai Sekarang",
                  onTap: () {
                    context.go('/auth');
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
