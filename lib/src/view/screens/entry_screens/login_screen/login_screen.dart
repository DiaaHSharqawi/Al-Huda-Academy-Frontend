import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './../../../../core/constants/app_colors.dart';
import './../../../../core/constants/app_images.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: Container(
          color: Colors.white,
          child: SizedBox.expand(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('السلام عليكم',
                        style: GoogleFonts.getFont(
                          'Almarai',
                          fontSize: 24.0,
                        )),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Text(
                      'مرحبا بك مجدداً',
                      style: GoogleFonts.getFont(
                        'Almarai',
                        fontSize: 16.0,
                      ),
                    ),
                    FittedBox(
                      child: Image.asset(
                        AppImages.holyQuranLogo,
                        width: 250,
                        height: 250,
                      ),
                    ),
                    Column(
                      children: [
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextFormField(
                            textAlign: TextAlign.right,
                            decoration: const InputDecoration(
                              labelText: "البريد الالكتروني",
                              hintText: 'diaa@gmail.com',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(
                                Icons.email,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextFormField(
                            obscureText: true,
                            textAlign: TextAlign.right,
                            decoration: const InputDecoration(
                              labelText: "كلمة السر",
                              hintText: '**********',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(
                                Icons.remove_red_eye,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            "نسيت كلمةالمرور ؟",
                            style: GoogleFonts.getFont(
                              'Almarai',
                              fontSize: 16.0,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.right,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () => {},
                            style: ButtonStyle(
                              foregroundColor:
                                  WidgetStateProperty.all(Colors.white),
                              backgroundColor: WidgetStateProperty.all(
                                AppColors.primaryColor,
                              ),
                              shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                            child: Text('تسجيل الدخول',
                                style: GoogleFonts.getFont(
                                  'Almarai',
                                  fontSize: 16.0,
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 24.0,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('مستخدم جديد',
                                  style: GoogleFonts.getFont(
                                    'Almarai',
                                    fontSize: 16.0,
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  )),
                              const SizedBox(
                                width: 12.0,
                              ),
                              Text(
                                'ليس لديك حساب ؟',
                                style: GoogleFonts.getFont(
                                  'Almarai',
                                  fontSize: 16.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ]),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
