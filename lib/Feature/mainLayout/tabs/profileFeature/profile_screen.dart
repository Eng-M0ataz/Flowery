import 'package:flower_e_commerce_app/Feature/auth/presentation/pages/sign_in_screen.dart';
import 'package:flower_e_commerce_app/core/helpers/dialogue_utils.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/app_routes.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Center(
            child: Text("Profile"),
          ),
          ElevatedButton(
            child:  Text(
              "Exit",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const SigninScreen()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  void showLogoutConfirmationDialog(
    BuildContext context,
  ) {
    DialogueUtils.showMessage(
      context: context,
      title: 'Confirm Logout',
      message: 'Are you sure you want to logout?',
      posActionName: 'Yes',
      posAction: () async {
        Navigator.pushReplacementNamed(context, AppRoutes.signInRoute);
      },
    );
  }
}
