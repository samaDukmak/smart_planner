// Home_pages.dart

// import 'package:flutter/material.dart';
// import 'package:flutter_application_5/features/auth/data/data_sources/logout_api.dart';
// import 'package:shared_preferences/shared_preferences.dart';


// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   Future<void> _logout(BuildContext context) async {
//     try {
//       final logoutApi = LogoutApi();
//       await logoutApi.logout();

//       final prefs = await SharedPreferences.getInstance();
//       await prefs.remove('token');
//       await prefs.remove('pendingOtp');
//       await prefs.remove('pendingEmail');

//       Navigator.pushReplacementNamed(context, '/login');
//     } catch (e) {
//       print('Logout error: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("فشل تسجيل الخروج")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('الصفحة الرئيسية'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () => _logout(context),
//           ),
//         ],
//       ),
//       body: Center(
//         child: Text(
//           'أهلاً بك في الصفحة الرئيسية ✨',
//           style: TextStyle(fontSize: 18),
//         ),

        
        
//       ),
       
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_application_5/features/auth/data/data_sources/logout_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null || token.isEmpty) {
      // ما في توكن → ما منرسل طلب
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("لم يتم العثور على جلسة صالحة")),
      );
      return;
    }

    try {
      print('▶️ [HomePage] Logging out with token: $token');
      final logoutApi = LogoutApi();
      await logoutApi.logout();  // بداخلها تطبع التوكين أيضاً

      await prefs.remove('token');
      await prefs.remove('pendingOtp');
      await prefs.remove('pendingEmail');

      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      print('🚨 Logout error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("فشل تسجيل الخروج")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الصفحة الرئيسية'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Center(
        child: Text(
          'أهلاً بك في الصفحة الرئيسية ✨',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

