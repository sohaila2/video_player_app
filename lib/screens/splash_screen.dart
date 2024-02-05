import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player_app/screens/home_screen.dart';

import '../widgets/linear_color.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    navigate();
  }

  void navigate(){
    Future.delayed(const Duration(seconds: 3),(){
      Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (_) =>
       VideoList()), (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: buildContainerDecoration(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            SizedBox(
            height: 160,
            child: Stack(
              children: [
                Positioned(
                  left: 80,
                  right: 80,
                  child: Image.asset(
                    "assets/images/Rectangle 22.png",
                  ),
                ),
                Positioned(
                  top: 75,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    "assets/images/SVGRepo_iconCarrier (3).png",
                    width:60,
                    height:60
                  ),
                ),
              ],
            ),
          ),
              const Text(
                "\t\Video\nPlayer",
                style: TextStyle(
                  color:Colors.white,
                  fontSize:18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  }
