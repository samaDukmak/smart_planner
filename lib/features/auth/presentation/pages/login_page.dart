// features/auth/presentation/pages/login_page.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_application_5/features/auth/presentation/cubit/auth_cubit.dart';
// import 'package:flutter_application_5/features/auth/presentation/cubit/auth_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   void _login(BuildContext context) {
//     final email = emailController.text.trim();
//     final password = passwordController.text.trim();
//     if (email.isEmpty || password.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('املأ كل الحقول')),
//       );
//       return;
//     }
//     context.read<AuthCubit>().login(email, password);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Login")),
//       body: BlocConsumer<AuthCubit, AuthState>(
//         listener: (context, state) {
//           if (state is LoginSuccess) {
//             Navigator.pushReplacementNamed(context, '/home');
//           } else if (state is LoginError) {
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
//                   controller: emailController,
//                   decoration: InputDecoration(labelText: "Email"),
//                 ),
//                 SizedBox(height: 12),
//                 TextField(
//                   controller: passwordController,
//                   obscureText: true,
//                   decoration: InputDecoration(labelText: "Password"),
//                 ),
//                 SizedBox(height: 24),
//                 ElevatedButton(
//                   onPressed: state is LoginLoading ? null : () => _login(context),
//                   child: state is LoginLoading
//                       ? CircularProgressIndicator(color: Colors.white)
//                       : Text("Login"),
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
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _login(BuildContext context) {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('املأ كل الحقول')),
      );
      return;
    }
    context.read<AuthCubit>().login(email, password);
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
              top: h * 0.40,
              left: 20,
              right: 20,
              child: Center(
                child: Column(
                  children: [
                    const Text(
                      "Smart Study Planner",
                      style: TextStyle(
                        fontSize: 24,
                        color: AppColors.white,
                        fontFamily: 'Serif',
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Study smarter, not harder ✨",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.white,
                        fontFamily: 'Serif',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 50),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is LoginSuccess) {
                          Navigator.pushReplacementNamed(context, '/home');
                           //Navigator.pushReplacementNamed(context, '/home');
                        } else if (state is LoginError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        }
                      },
                      builder: (context, state) {
                        return Column(
                          children: [
                            _textField(emailController, 'Email'),
                            const SizedBox(height: 7),
                            _textField(passwordController, 'Password',
                                obscure: true),
                            const SizedBox(height: 15),
                            SizedBox(
                              width: 231,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 100, 129, 202),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                onPressed: state is LoginLoading
                                    ? null
                                    : () => _login(context),
                                child: state is LoginLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white)
                                    : const Text(
                                        'Login',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: AppColors.white),
                                      ),
                              ),
                            ),
                            SizedBox(height: 15),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('/signup');
                              },
                              child: const Text(
                                "Don't have an account? Sign Up",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontFamily: 'Serif',
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      }),
    );
  }

  Widget _textField(TextEditingController controller, String hint,
      {bool obscure = false}) {
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
