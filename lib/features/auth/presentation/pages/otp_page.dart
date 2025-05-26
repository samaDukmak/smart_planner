// features/auth/presentation/pages/otp_page.dart


// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_application_5/features/auth/presentation/cubit/auth_cubit.dart';
// import 'package:flutter_application_5/features/auth/presentation/cubit/auth_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class OtpPage extends StatefulWidget {
//   final String email; // نمرره من صفحة التسجيل

//   const OtpPage({required this.email});

//   @override
//   _OtpPageState createState() => _OtpPageState();
// }

// class _OtpPageState extends State<OtpPage> {
//   final otpController = TextEditingController();

//   void _verifyOtp() {
//     final otp = otpController.text.trim();

//     if (otp.length != 6) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("الرمز يجب أن يكون 6 أرقام")),
//       );
//       return;
//     }

//     context.read<AuthCubit>().verifyOtp(widget.email, otp);
//   }

//   void _resendOtp() {
//     context.read<AuthCubit>().resendOtp(widget.email);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("تم إرسال كود جديد إلى البريد")),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      
//       appBar: AppBar(title: Text("رمز التحقق")),
//       body: BlocConsumer<AuthCubit, AuthState>(
//         listener: (context, state) {
//           if (state is OtpSuccess) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text("تم التحقق بنجاح")),
//             );
//             Navigator.pushReplacementNamed(context, '/home');
//           } else if (state is OtpError) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(state.message)),
//             );
//           }
//         },
//         builder: (context, state) {
//           return Padding(
//             padding: const EdgeInsets.all(24),
//             child: Column(
//               children: [
//                 TextField(
//                   controller: otpController,
//                   keyboardType: TextInputType.number,
//                   maxLength: 6,
//                   decoration: InputDecoration(
//                     labelText: "أدخل رمز OTP",
//                     counterText: "",
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: state is OtpLoading ? null : _verifyOtp,
//                   child: state is OtpLoading
//                       ? CircularProgressIndicator(color: Colors.white)
//                       : Text("تحقق"),
//                 ),
//                 TextButton(
//                   onPressed: _resendOtp,
//                   child: Text("إعادة إرسال الرمز"),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_application_5/core/constants/app_colors.dart';

import 'package:flutter_application_5/core/models/PlanetConfig.dart';
import 'package:flutter_application_5/core/widgets/custom_shapes/star_background.dart';
import 'package:flutter_application_5/core/widgets/planetwidget.dart';
import 'package:flutter_application_5/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_application_5/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpPage extends StatefulWidget {
  final String email;
  const OtpPage({required this.email});

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  void _verifyOtp() {
    final otp = _controllers.map((c) => c.text).join();
    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("الرمز يجب أن يكون 6 أرقام")),
      );
      return;
    }
    context.read<AuthCubit>().verifyOtp(widget.email, otp);
  }

  void _resendOtp() {
    context.read<AuthCubit>().resendOtp(widget.email);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("تم إرسال كود جديد إلى البريد")),
    );
  }

  @override
  Widget build(BuildContext context) {
    const designWidth = 393.0;
    const designHeight = 852.0;

    final planets = <PlanetConfig>[
      PlanetConfig(
          assetPath: 'assets/Lightblue.webp',
          leftPct: 19.0 / designWidth, // X=0
          topPct: 297.0 / designHeight, // Y=173 على 852
          width: 61,
          height: 62),
      PlanetConfig(
        assetPath: 'assets/orange_plant.webp',
        leftPct: 64.0 / designWidth, // X=0
        topPct: 76.0 / designHeight, // Y=173 على 852
        width: 88,
        height: 67,
      ),
      PlanetConfig(
        assetPath: 'assets/blue.webp',
        leftPct: 220.0 / designWidth, // X=0
        topPct: 91.0 / designHeight, // Y=173 على 852
        width: 113,
        height: 114,
      ),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.darkBg,
      body: LayoutBuilder(builder: (ctx, cons) {
        final w = cons.maxWidth;
        final h = cons.maxHeight;

        return Stack(
          children: [
            const Positioned.fill(
              child: RandomStarBackground(starCount: 60),
            ),
            for (final cfg in planets)
              PlanetWidget(config: cfg, parentSize: Size(w, h)),

            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is OtpSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("تم التحقق بنجاح")),
                      );
                      Navigator.pushReplacementNamed(context, '/home');
                        // Navigator.pushReplacementNamed(context, '/home');
                    } else if (state is OtpError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "تحقق من الرمز",
                          style: TextStyle(
                            fontSize: 24,
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(6, (i) {
                            return Container(
                              width: 40,
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              child: TextField(
                                controller: _controllers[i],
                                focusNode: _focusNodes[i],
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                maxLength: 1,
                                style: TextStyle(fontSize: 22),
                                decoration: InputDecoration(
                                  counterText: '',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onChanged: (val) {
                                  if (val.isNotEmpty && i < 5) {
                                    _focusNodes[i + 1].requestFocus();
                                  } else if (val.isEmpty && i > 0) {
                                    _focusNodes[i - 1].requestFocus();
                                  }
                                },
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: state is OtpLoading ? null : _verifyOtp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 100, 129, 202),
                          ),
                          child: state is OtpLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text("تحقق", style: TextStyle(fontSize: 16)),
                        ),
                        const SizedBox(height: 15),
                        TextButton(
                          onPressed: _resendOtp,
                          child: Text("إعادة إرسال الرمز",
                              style: TextStyle(color: Colors.white)),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

