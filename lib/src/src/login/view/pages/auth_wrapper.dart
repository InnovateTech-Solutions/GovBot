import 'package:flutter/material.dart';
import 'package:govbot/src/src/dashboard/pages/dashboard_drawe.dart';
import 'package:govbot/src/src/login/view/pages/login_page.dart';
import 'package:govbot/src/src/register/view/page/register_page.dart';

// class AuthWrapper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator();
//         } else if (snapshot.hasData) {
//           return const DashboardDrawer();
//         } else {
//           return const RegisterPage();
//         }
//       },
//     );
//   }
// }
