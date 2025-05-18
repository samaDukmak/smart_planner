// features/Auth/presentation/pages/signup_page.dart

// import 'package:flutter/material.dart';
// import 'package:flutter_application_5/features/auth/presentation/cubit/auth_cubit.dart';
// import 'package:flutter_application_5/features/auth/presentation/cubit/auth_state.dart';
// import 'package:flutter_application_5/features/auth/presentation/pages/otp_page.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SignupPage extends StatefulWidget {
//   @override
//   _SignupPageState createState() => _SignupPageState();
// }

// class _SignupPageState extends State<SignupPage> {
//   final userNameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final confirmPasswordController = TextEditingController();

//   void _signup() {
//     final userName = userNameController.text.trim();
//     final email = emailController.text.trim();
//     final password = passwordController.text.trim();
//     final confirmPassword = confirmPasswordController.text.trim();

//     if (userName.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('املأ جميع الحقول')),
//       );
//       return;
//     }

//     if (password != confirmPassword) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('كلمة المرور وتأكيدها غير متطابقين')),
//       );
//       return;
//     }

//     context.read<AuthCubit>().signup(userName, email, password, confirmPassword);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Signup")),
//       body: BlocConsumer<AuthCubit, AuthState>(
//         listener: (context, state) {
//           if (state is SignupSuccess) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text("تم إنشاء الحساب بنجاح")),
//             );
//            Navigator.pushReplacement(
//   context,
//   MaterialPageRoute(
//     builder: (_) => OtpPage(email: emailController.text.trim()),
//   ),
// );
//           } else if (state is SignupError) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(state.message)),
//             );
//           }
//         },
//         builder: (context, state) {
//           return Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 TextField(
//                   controller: userNameController,
//                   decoration: InputDecoration(labelText: "Username"),
//                 ),
//                 TextField(
//                   controller: emailController,
//                   decoration: InputDecoration(labelText: "Email"),
//                 ),
//                 TextField(
//                   controller: passwordController,
//                   obscureText: true,
//                   decoration: InputDecoration(labelText: "Password"),
//                 ),
//                 TextField(
//                   controller: confirmPasswordController,
//                   obscureText: true,
//                   decoration: InputDecoration(labelText: "Confirm Password"),
//                 ),
//                 SizedBox(height: 24),
//                 ElevatedButton(
//                   onPressed: state is SignupLoading ? null : _signup,
//                   child: state is SignupLoading
//                       ? CircularProgressIndicator(color: Colors.white)
//                       : Text("Signup"),
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
import 'package:flutter_application_5/core/constants/planet_assets.dart';
import 'package:flutter_application_5/core/models/PlanetConfig.dart';
import 'package:flutter_application_5/core/widgets/custom_shapes/star_background.dart';
import 'package:flutter_application_5/core/widgets/planetwidget.dart';
import 'package:flutter_application_5/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_application_5/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter_application_5/features/auth/presentation/pages/otp_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void _signup() {
    final userName = userNameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (userName.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('املأ جميع الحقول')),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('كلمة المرور وتأكيدها غير متطابقين')),
      );
      return;
    }

    context.read<AuthCubit>().signup(userName, email, password, confirmPassword);
  }

  @override
  Widget build(BuildContext context) {
    const designWidth = 393.0;
    const designHeight = 852.0;

    final planets = <PlanetConfig>[
      PlanetConfig(
        assetPath: PlanetAssets.plants,
        leftPct: 71 / designWidth,
        topPct: 55.5 / designHeight,
        width: 250,
        height: 280,
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
              child: RandomStarBackground(starCount: 60, color: Colors.white70),
            ),
            for (final cfg in planets)
              PlanetWidget(config: cfg, parentSize: Size(w, h)),

            Positioned(
              top: h * 0.4,
              left: 20,
              right: 20,
              child: Center(
                child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is SignupSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("تم إنشاء الحساب بنجاح")),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => OtpPage(email: emailController.text.trim()),
                        ),
                      );
                    } else if (state is SignupError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      children: [
                        Text(
                          "Sign up to start your journey 🚀",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.white,
                            fontFamily: 'Serif',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 20),
                        _buildTextField(userNameController, 'User Name'),
                        SizedBox(height: 7),
                        _buildTextField(emailController, 'Email'),
                        SizedBox(height: 7),
                        _buildTextField(passwordController, 'Password', obscure: true),
                        SizedBox(height: 7),
                        _buildTextField(confirmPasswordController, 'Confirm Password', obscure: true),
                        SizedBox(height: 15),
                        SizedBox(
                          width: 231,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 100, 129, 202),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: state is SignupLoading ? null : _signup,
                            child: state is SignupLoading
                                ? CircularProgressIndicator(color: Colors.white)
                                : const Text('Sign Up', style: TextStyle(fontSize: 18, color: AppColors.white)),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        );
      }),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {bool obscure = false}) {
    return SizedBox(
      width: 261,
      height: 48,
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.white,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

