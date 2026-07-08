import 'package:finance/widgets/WaveAndLoading.dart';
import 'package:flutter/material.dart';

class SplashHomeView extends StatefulWidget {
  const SplashHomeView({super.key});

  static String id = 'SplashHomeView';

  @override
  State<SplashHomeView> createState() => _SplashHomeViewState();
}

class _SplashHomeViewState extends State<SplashHomeView> {
  @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(const Duration(seconds: 2), () {
  //     if (!mounted) return;
  //     if (FirebaseAuth.instance.currentUser != null) {
  //       Navigator.pushReplacementNamed(context, HomeView.id);
  //     } else {
  //       Navigator.pushReplacementNamed(context, LoginView.id);
  //     }
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              'assets/images/ChatGPT Image May 23, 2026, 01_27_50 PM.png',
              fit: BoxFit.cover,
            ),
          ),

          const WaveAndLoading(),
        ],
      ),
    );
  }
}
